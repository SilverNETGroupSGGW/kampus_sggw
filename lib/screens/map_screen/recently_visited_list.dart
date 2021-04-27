import 'package:flutter/material.dart';
import 'package:kampus_sggw/logic/visited_items.dart';
import 'package:kampus_sggw/models/map_item.dart';

class RecentlyVisitedList extends StatefulWidget {
  final VisitedItems visitedItems;

  const RecentlyVisitedList({
    Key key,
    @required this.visitedItems,
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
      leading: Icon(Icons.park),
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

  void _onTapFunc(MapItem item) {
    setState(() {
      widget.visitedItems.addItem(item.id);
      _updateRecentlyVisited();
    });
  }

  void _updateRecentlyVisited() =>
      _visitedItems = widget.visitedItems.filterVisitedItems();
}
