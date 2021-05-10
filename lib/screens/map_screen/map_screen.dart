import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:kampus_sggw/global_widgets/side_drawer.dart';
import 'package:kampus_sggw/logic/filter_button_service.dart';
import 'package:kampus_sggw/logic/filter_service.dart';
import 'package:kampus_sggw/logic/search_history.dart';
import 'package:kampus_sggw/logic/stream_service.dart';
import 'package:kampus_sggw/logic/visited_items.dart';
import 'package:kampus_sggw/models/map_item.dart';
import 'package:kampus_sggw/models/map_items.dart';
import 'package:kampus_sggw/translations/locale_keys.g.dart';
import 'info_card.dart';
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
  StreamService _recenterButtonNotifier = StreamService();
  StreamService _filterButtonNotifier = StreamService();
  StreamService _shouldUpdateMapMarkers = StreamService();
  StreamService _unfilterButtonNotifier = StreamService();
  StreamService _shouldAddRecentlyVisitedItem = StreamService();

  showInfoCard(MapItem mapItem) {
    _selectedMapItem = mapItem;
    Navigator.of(context).restorablePush(_dialogBuilder);
  }

  static Route<Object> _dialogBuilder(BuildContext context, Object arguments) {
    return DialogRoute<void>(
      context: context,
      builder: (BuildContext context) =>
          InfoCardDialog.fromMapItem(_selectedMapItem),
    );
  }

  void _addItemToRecentlyVisited(int mapItemId) {
    widget.visitedItems.addItem(mapItemId);
    widget.visitedItems.save();
  }

  void _notifyInteractiveMap(FilterButtonService filterButtonService) {
    FilterService filterService = FilterService(
        filterName: filterButtonService.filterName,
        filteredMapItems: widget.mapItems.filter(filterButtonService));
    _shouldUpdateMapMarkers.addEvent(filterService);
  }

  @override
  void initState() {
    super.initState();
    _shouldAddRecentlyVisitedItem
        .listen((mapItemId) => _addItemToRecentlyVisited(mapItemId));
    _filterButtonNotifier.listen(
        (filterButtonService) => _notifyInteractiveMap(filterButtonService));
  }

  @override
  void dispose() {
    widget.visitedItems.save();
    _recenterButtonNotifier.dispose();
    _filterButtonNotifier.cancelSubscription();
    _filterButtonNotifier.dispose();
    _shouldUpdateMapMarkers.dispose();
    _unfilterButtonNotifier.dispose();
    _shouldAddRecentlyVisitedItem.cancelSubscription();
    _shouldAddRecentlyVisitedItem.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          LocaleKeys.map_screen_title.tr(),
          style: TextStyle(
            fontFamily: 'SGGWMastro',
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Stack(
        children: [
          InteractiveMap(
            mapItems: widget.mapItems,
            showCard: showInfoCard,
            shouldRecenter: _recenterButtonNotifier,
            shouldFilterMarkers: _shouldUpdateMapMarkers,
            shouldUnfilterMarkers: _unfilterButtonNotifier,
            recentlyVisitedItemNotifier: _shouldAddRecentlyVisitedItem,
          ),
        ],
      ),
      floatingActionButton: MapFloatingButtons(
        searchHistory: widget.searchHistory,
        visitedItems: widget.visitedItems,
        onRecenterButtonPressed: () => _recenterButtonNotifier.addEvent(null),
        filtrationNotifier: _shouldUpdateMapMarkers,
        filterButtonNotifier: _filterButtonNotifier,
        onUnfilterButtonPressed: () => _unfilterButtonNotifier.addEvent(null),
      ),
      drawer: SideDrawer(),
    );
  }
}
