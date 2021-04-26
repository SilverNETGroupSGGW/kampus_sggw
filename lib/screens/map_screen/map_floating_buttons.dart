import 'package:flutter/material.dart';
import 'package:kampus_sggw/logic/search_history.dart';
import 'package:kampus_sggw/logic/visited_items.dart';
import 'package:kampus_sggw/models/map_items.dart';
import 'search_bar.dart';

class MapFloatingButtons extends StatelessWidget {
  final SearchHistory searchHistory;
  final VisitedItems visitedItems;
  final MapItems mapItems;

  const MapFloatingButtons({
    Key key,
    this.searchHistory,
    this.visitedItems,
    this.mapItems,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(visitedItems);
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        FloatingActionButton(
          child: const Icon(Icons.map),
          backgroundColor: Colors.lightGreen,
          onPressed: () {},
        ),
        Padding(
          padding: EdgeInsets.all(5),
        ),
        FloatingActionButton(
          child: const Icon(Icons.search),
          backgroundColor: Colors.green,
          onPressed: () => _onSearchButtonPressed(context),
        ),
      ],
    );
  }

  void _onSearchButtonPressed(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.6,
        child: SearchBar(
          searchHistory: searchHistory,
          visitedItems: visitedItems,
          mapItems: mapItems,
        ),
      ),
    );
  }
}
