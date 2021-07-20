import 'dart:async';

import 'package:flutter/material.dart';
import 'package:kampus_sggw/logic/event_parameters/markers_event_param.dart';
import 'package:kampus_sggw/logic/search_services/markers_service.dart';

class SearchButton extends ChangeNotifier {
  FloatingActionButton button;
  Function _onSearchButtonPressed;
  Function _collapseBottomDrawer;
  StreamSubscription _createUnfilterButton;
  MarkersService _markersService;

  SearchButton(onPressed, markersService, collapseBottomDrawer) {
    _collapseBottomDrawer = collapseBottomDrawer;
    _markersService = markersService;
    _onSearchButtonPressed = onPressed;
    _createUnfilterButton = _markersService.filterEvent
        .listen((eventParam) => _unfilter(eventParam));
    button = _searchButton();
  }

  FloatingActionButton _searchButton() {
    return FloatingActionButton(
      child: const Icon(Icons.search),
      backgroundColor: Colors.green,
      onPressed: () => _onSearchButtonPressed(),
    );
  }

  FloatingActionButton _unfilterButton(String filterName) {
    return FloatingActionButton.extended(
      onPressed: () => _restoreToDefault(),
      label: Container(
        constraints: BoxConstraints(maxWidth: 200),
        child: Text(
          filterName,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontFamily: 'SGGWSans',
            fontSize: 20,
          ),
        ),
      ),
      icon: const Icon(Icons.clear),
      backgroundColor: Colors.green,
    );
  }

  void _unfilter(MarkersEventParam eventParam) {
    //Navigator.pop(context);
    _collapseBottomDrawer();
    button = _unfilterButton(eventParam.filterName);
    return notifyListeners();
  }

  void _restoreToDefault() {
    _markersService.unfilterEvent.trigger();
    button = _searchButton();
    return notifyListeners();
  }

  void dispose() {
    _createUnfilterButton.cancel();
    super.dispose();
  }
}
