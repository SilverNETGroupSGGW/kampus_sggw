import 'package:flutter/material.dart';
import 'package:kampus_sggw/logic/visited_items.dart';
import 'package:kampus_sggw/models/map_item.dart';

class RecentlyVisitedList extends StatefulWidget {
  final VisitedItems visitedItems;
  final Function onItemTilePressed;

  const RecentlyVisitedList({
    Key key,
    @required this.visitedItems,
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
    _visitedItems = widget.visitedItems.filterVisitedItems();
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
      leading: Container(
        child: _mapItemIcon(item.type),
        width: 30,
        height: 30,
      ),
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
              widget.visitedItems.deleteItem(item.id);
              _updateRecentlyVisited();
            });
          }),
    );
  }

  Image _mapItemIcon(MapItemType type) {
    if (type == MapItemType.facultyBuilding)
      return Image.asset('assets/images/icons/faculty.png');

    if (type == MapItemType.administrationBuilding)
      return Image.asset('assets/images/icons/administration.png');

    if (type == MapItemType.dormitories)
      return Image.asset('assets/images/icons/hotel.png');

    if (type == MapItemType.sportsFacility)
      return Image.asset('assets/images/icons/sport.png');

    return Image.asset('assets/images/icons/other.png');
  }

  void _onTapFunc(MapItem item) {
    setState(() {
      widget.visitedItems.addItem(item.id);
      _updateRecentlyVisited();
      widget.onItemTilePressed(item);
    });
  }

  void _updateRecentlyVisited() =>
      _visitedItems = widget.visitedItems.filterVisitedItems();
}
