import 'package:flutter/material.dart';
import 'package:kampus_sggw/logic/visit_history.dart';
import 'package:kampus_sggw/models/map_item.dart';
import 'package:kampus_sggw/models/map_items.dart';
import 'package:provider/provider.dart';

class RecentlyVisitedList extends StatefulWidget {
  final VisitHistory visitHistory;
  final Function onItemTilePressed;

  const RecentlyVisitedList({
    Key key,
    @required this.visitHistory,
    @required this.onItemTilePressed,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _RecentlyVisitedList();
}

class _RecentlyVisitedList extends State<RecentlyVisitedList> {
  List<MapItem> _visitedItems;

  @override
  void initState() {
    super.initState();
    _visitedItems = widget.visitHistory.updateMapItems(
      Provider.of<MapItems>(context, listen: false),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        physics: NeverScrollableScrollPhysics(),
        children: _visitedItems
            .map((item) => Card(child: _recentlyVisitedItemCard(item)))
            .toList(),
      ),
    );
  }

  ListTile _recentlyVisitedItemCard(MapItem item) {
    return ListTile(
      onTap: () => _onTapFunc(item),
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
              widget.visitHistory.deleteItem(item);
              _updateRecentlyVisited();
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

  void _onTapFunc(MapItem item) {
    setState(() {
      widget.visitHistory.addItem(item);
      _updateRecentlyVisited();
      widget.onItemTilePressed(item);
    });
  }

  void _updateRecentlyVisited() =>
      _visitedItems = widget.visitHistory.updateMapItems(
        Provider.of<MapItems>(context, listen: false),
      );
}
