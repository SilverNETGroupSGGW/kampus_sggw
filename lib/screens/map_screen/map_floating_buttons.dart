import 'dart:async';

import 'package:flutter/material.dart';
import 'package:kampus_sggw/logic/event_parameters/update_markers_event_param.dart';
import 'package:kampus_sggw/logic/filtration_service.dart';
import 'package:kampus_sggw/logic/search_history.dart';
import 'package:kampus_sggw/logic/visited_items.dart';
import 'filtration_widgets/search_bar.dart';

class MapFloatingButtons extends StatefulWidget {
  final SearchHistory searchHistory;
  final VisitedItems visitedItems;
  final Function onRecenterButtonPressed;
  final FiltrationService filtrationService;
  //final StreamService filterButtonNotifier;
  //final StreamService searchBarNotifier;
  //final StreamService filtrationNotifier;

  const MapFloatingButtons({
    Key key,
    @required this.searchHistory,
    @required this.visitedItems,
    @required this.onRecenterButtonPressed,
    @required this.filtrationService,
    //@required this.filterButtonNotifier,
    //@required this.searchBarNotifier,
    //@required this.filtrationNotifier,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MapFloatingButtons();
}

class _MapFloatingButtons extends State<MapFloatingButtons> {
  var _searchButton;
  StreamSubscription _createUnfilterButton;

  @override
  initState() {
    super.initState();
    _searchButton = _filterButton();
    _createUnfilterButton = widget.filtrationService.filterMarkersEvent.listen(
        (eventParam) => _replaceFilterButtonWithUnfilterButton(eventParam));
  }

  @override
  void dispose() {
    _createUnfilterButton.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        FloatingActionButton(
          child: const Icon(Icons.map),
          backgroundColor: Colors.lightGreen,
          onPressed: () => widget.onRecenterButtonPressed(),
          heroTag: "btn1",
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
        widget.filtrationService.unfilterMarkersEvent.trigger();
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
          filtrationService: widget.filtrationService,
        ),
      ),
    );
  }

  void _replaceFilterButtonWithUnfilterButton(
      UpdateMarkersEventParam eventParam) {
    Navigator.pop(context);
    setState(
      () {
        _searchButton = _unfilterButton(eventParam.filterName);
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
