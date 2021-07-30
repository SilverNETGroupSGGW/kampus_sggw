import 'package:flutter/material.dart';
import 'package:kampus_sggw/logic/histories/visit_history.dart';
import 'package:kampus_sggw/logic/search_bar_controller.dart';
import 'package:kampus_sggw/logic/search_services/search_service.dart';
import 'package:kampus_sggw/models/map_item.dart';
import 'package:kampus_sggw/models/map_items.dart';
import 'package:provider/provider.dart';

class VisitHistoryList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _VisitHistoryList();
}

class _VisitHistoryList extends State<VisitHistoryList> {
  VisitHistory _visitHistory;

  @override
  void initState() {
    super.initState();
    _visitHistory = _initializeVisitHistory();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        physics: NeverScrollableScrollPhysics(),
        children: _visitHistory.storedMapItems
            .map((item) => Card(child: _recentlyVisitedItemCard(item)))
            .toList(),
      ),
    );
  }

  ListTile _recentlyVisitedItemCard(MapItem item) {
    return ListTile(
      onTap: () => _showItemOnMap(item),
      leading: _mapItemIcon(item.type),
      title: Text(
        item.name,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(fontSize: 18),
      ),
      dense: true,
      trailing: IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            setState(() {
              _visitHistory.deleteItem(item);
            });
          }),
    );
  }

  Icon _mapItemIcon(MapItemType type) {
    if (type == MapItemType.facultyBuilding) return Icon(Icons.school_outlined);
    if (type == MapItemType.administrationBuilding)
      return Icon(Icons.corporate_fare_outlined);
    if (type == MapItemType.dormitories) return Icon(Icons.hotel_outlined);
    if (type == MapItemType.sportsFacility) return Icon(Icons.sports_soccer);
    if (type == MapItemType.finance) return Icon(Icons.attach_money_outlined);
    if (type == MapItemType.food) return Icon(Icons.restaurant_outlined);
    if (type == MapItemType.library) return Icon(Icons.local_library_outlined);
    if (type == MapItemType.parking) return Icon(Icons.local_parking_outlined);
    if (type == MapItemType.store) return Icon(Icons.storefront_outlined);
    if (type == MapItemType.transport)
      return Icon(Icons.directions_bus_outlined);

    return Icon(Icons.info_outline);
  }

  void _showItemOnMap(MapItem item) {
    _visitHistory.addItem(item);
    Provider.of<SearchService>(context, listen: false).search(item);
    Provider.of<SearchBarController>(context, listen: false).close();
  }

  VisitHistory _initializeVisitHistory() {
    VisitHistory visitHistory =
        Provider.of<VisitHistory>(context, listen: false);
    visitHistory.loadMapItems(
      Provider.of<MapItems>(context, listen: false),
    );
    return visitHistory;
  }
}
