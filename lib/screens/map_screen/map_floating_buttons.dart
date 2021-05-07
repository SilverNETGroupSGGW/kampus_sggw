import 'package:flutter/material.dart';
import 'package:kampus_sggw/logic/search_history.dart';
import 'package:kampus_sggw/logic/stream_service.dart';
import 'package:kampus_sggw/logic/visited_items.dart';
import 'search_panel/search_bar.dart';

class MapFloatingButtons extends StatelessWidget {
  final SearchHistory searchHistory;
  final VisitedItems visitedItems;
  final Function onRecenterButtonPressed;
  final StreamService filterButtonNotifier;

  const MapFloatingButtons({
    Key key,
    @required this.searchHistory,
    @required this.visitedItems,
    @required this.onRecenterButtonPressed,
    @required this.filterButtonNotifier,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        FloatingActionButton(
          child: const Icon(Icons.map),
          backgroundColor: Colors.lightGreen,
          onPressed: () => onRecenterButtonPressed(),
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
          filterButtonNotifier: filterButtonNotifier,
        ),
      ),
    );
  }
}
