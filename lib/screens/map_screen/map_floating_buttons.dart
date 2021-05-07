import 'package:flutter/material.dart';
import 'package:kampus_sggw/logic/filter_service.dart';
import 'package:kampus_sggw/logic/search_history.dart';
import 'package:kampus_sggw/logic/stream_service.dart';
import 'package:kampus_sggw/logic/visited_items.dart';
import 'search_panel/search_bar.dart';

class MapFloatingButtons extends StatefulWidget {
  final SearchHistory searchHistory;
  final VisitedItems visitedItems;
  final Function onRecenterButtonPressed;
  final StreamService filterButtonNotifier;
  final Function onUnfilterButtonPressed;

  const MapFloatingButtons({
    Key key,
    @required this.searchHistory,
    @required this.visitedItems,
    @required this.onRecenterButtonPressed,
    @required this.filterButtonNotifier,
    @required this.onUnfilterButtonPressed,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MapFloatingButtons();
}

class _MapFloatingButtons extends State<MapFloatingButtons> {
  var _searchButton;

  @override
  initState() {
    super.initState();
    _searchButton = _filterButton();
    widget.filterButtonNotifier.listen((filterService) =>
        _replaceFilterButtonWithUnfilterButton(filterService));
  }

  @override
  void dispose() {
    widget.filterButtonNotifier.cancelSubscription();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        FloatingActionButton(
          child: const Icon(Icons.map),
          backgroundColor: Colors.lightGreen,
          onPressed: () => widget.onRecenterButtonPressed(),
        ),
        Padding(
          padding: EdgeInsets.all(5),
        ),
        _searchButton,
      ],
    );
  }

  TextButton _unfilterButton(String filterName) {
    return TextButton.icon(
      label: Text(filterName),
      icon: Icon(Icons.clear),
      onPressed: () {
        widget.onUnfilterButtonPressed();
        _replaceUnfilterButtonWithFilterButton();
      },
      style: TextButton.styleFrom(
        backgroundColor: Colors.green,
        primary: Colors.white,
        textStyle: TextStyle(fontFamily: 'SGGWSans', fontSize: 20),
      ),
    );
  }

  FloatingActionButton _filterButton() {
    return FloatingActionButton(
      child: const Icon(Icons.search),
      backgroundColor: Colors.green,
      onPressed: () => _onSearchButtonPressed(context),
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
          searchHistory: widget.searchHistory,
          visitedItems: widget.visitedItems,
          filterButtonNotifier: widget.filterButtonNotifier,
        ),
      ),
    );
  }

  void _replaceFilterButtonWithUnfilterButton(FilterService filterService) {
    Navigator.pop(context);
    setState(
      () {
        _searchButton = _unfilterButton(filterService.filterName);
      },
    );
  }

  void _replaceUnfilterButtonWithFilterButton() {
    setState(
      () {
        _searchButton = _filterButton();
      },
    );
  }
}
