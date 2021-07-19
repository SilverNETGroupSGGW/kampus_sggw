import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:kampus_sggw/global_widgets/side_drawer.dart';
import 'package:kampus_sggw/logic/search_services/search_service.dart';
import 'package:kampus_sggw/logic/search_services/stream_service.dart';
import 'package:kampus_sggw/logic/info_card_dialog_builder.dart';
import 'package:kampus_sggw/models/map_item.dart';
import 'package:kampus_sggw/translations/locale_keys.g.dart';
import 'package:provider/provider.dart';
import 'filtration_widgets/no_item_found_alert_dialog.dart';
import 'interactive_map.dart';
import 'map_floating_buttons.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  static MapItem _selectedMapItem;

  StreamService _recenterMap = StreamService();

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
    Provider.of<SearchService>(context, listen: false).onNoItemFound =
        _showAlertDialogNoItemFound;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
            showCard: showInfoCard,
            shouldRecenter: _recenterMap,
          ),
        ],
      ),
      floatingActionButton: MapFloatingButtons(
        onRecenterButtonPressed: () => _recenterMap.trigger(),
      ),
      drawer: SideDrawer(),
    );
  }

  @override
  void dispose() {
    _recenterMap.dispose();
    super.dispose();
  }
}
