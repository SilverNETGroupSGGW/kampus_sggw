import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:kampus_sggw/global_widgets/side_drawer.dart';
import 'package:kampus_sggw/models/map_item.dart';
import 'package:kampus_sggw/models/map_items.dart';
import 'package:kampus_sggw/translations/locale_keys.g.dart';
import 'info_card.dart';
import 'interactive_map.dart';
import 'map_floating_buttons.dart';

class MapScreen extends StatefulWidget {
  final MapItems mapItems;

  MapScreen ({ Key key, this.mapItems }): super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  static MapItem _selectedMapItem;

  showInfoCard(MapItem mapItem) {
    _selectedMapItem = mapItem;
    Navigator.of(context).restorablePush(_dialogBuilder);
  }

  static Route<Object> _dialogBuilder(BuildContext context, Object arguments) {
    return DialogRoute<void>(
      context: context,
      builder: (BuildContext context) =>
          InfoCardDialog.fromBuilding(_selectedMapItem),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.map_screen_title.tr()),
      ),
      body: Stack(
        children: [
          InteractiveMap(
            widget.mapItems.mapItems,
            showInfoCard,
          ),
        ],
      ),
      floatingActionButton: MapFloatingButtons(),
      drawer: SideDrawer(),
    );
  }
}
