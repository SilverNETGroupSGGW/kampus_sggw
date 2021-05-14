import 'dart:async';

import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:kampus_sggw/global_widgets/side_drawer.dart';
import 'package:kampus_sggw/logic/filtration_service.dart';
import 'package:kampus_sggw/logic/search_history.dart';
import 'package:kampus_sggw/logic/stream_service.dart';
import 'package:kampus_sggw/logic/visited_items.dart';
import 'package:kampus_sggw/models/map_item.dart';
import 'package:kampus_sggw/models/map_items.dart';
import 'package:kampus_sggw/screens/map_screen/map_item_display/InfoCardDialogBuilder.dart';
import 'package:kampus_sggw/translations/locale_keys.g.dart';
import 'filtration_widgets/no_item_found_alert_dialog.dart';
import 'map_item_display/info_card.dart';
import 'interactive_map.dart';
import 'map_floating_buttons.dart';

class MapScreen extends StatefulWidget {
  final MapItems mapItems;
  final SearchHistory searchHistory;
  final VisitedItems visitedItems;

  MapScreen({
    Key key,
    this.mapItems,
    this.searchHistory,
    this.visitedItems,
  }) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  static MapItem _selectedMapItem;
  StreamService _recenterMap = StreamService();
  StreamService _visitItem = StreamService();
  FiltrationService _filtrationService;
  StreamSubscription _visitItemListener;

  showInfoCard(MapItem mapItem) {
    _selectedMapItem = mapItem;
    Navigator.of(context).restorablePush(_dialogBuilder);
  }

  static Route<Object> _dialogBuilder(BuildContext context, Object arguments) {
    return DialogRoute<void>(
      context: context,
      builder: (BuildContext context) =>
        InfoCardDialogBuilder().fromMapItem(_selectedMapItem),
    );
  }

  void _addItemToRecentlyVisited(MapItem mapItem) {
    widget.visitedItems.addItem(mapItem.id);
    widget.visitedItems.save();
  }

  void _showAlertDialogNoItemFound() {
    Navigator.pop(context);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return NoItemFoundAlertDialog();
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _filtrationService = FiltrationService(
        mapItems: widget.mapItems, onNoItemFound: _showAlertDialogNoItemFound);
    _visitItemListener =
        _visitItem.listen((mapItem) => _addItemToRecentlyVisited(mapItem));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          LocaleKeys.map_screen_title.tr(),
          style: TextStyle(
            fontFamily: 'SGGWSans',
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Stack(
        children: [
          InteractiveMap(
            mapItems: widget.mapItems,
            showCard: showInfoCard,
            onItemVisit: (mapItem) => _visitItem.trigger(param: mapItem),
            shouldRecenter: _recenterMap,
            shouldFilterMarkers: _filtrationService.filterMarkersEvent,
            shouldUnfilterMarkers: _filtrationService.unfilterMarkersEvent,
          ),
        ],
      ),
      floatingActionButton: MapFloatingButtons(
        searchHistory: widget.searchHistory,
        visitedItems: widget.visitedItems,
        onRecenterButtonPressed: () => _recenterMap.trigger(),
        filtrationService: _filtrationService,
      ),
      drawer: SideDrawer(),
    );
  }

  @override
  void dispose() {
    widget.visitedItems.save();
    _visitItemListener.cancel();
    _recenterMap.dispose();
    _visitItem.dispose();
    _filtrationService.dispose();
    super.dispose();
  }
}
