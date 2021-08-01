import 'package:flutter/material.dart';
import 'package:kampus_sggw/logic/map_markers_controller.dart';
import 'package:kampus_sggw/logic/search_services/search_service.dart';

class SearchButtonController extends ChangeNotifier {
  FloatingActionButton _button;
  Function _onSearchButtonPressed;
  Function _collapseBottomDrawer;
  MapMarkersConroller _mapMarkers;

  FloatingActionButton get button => _button;

  SearchButtonController({
    SearchService searchService,
    MapMarkersConroller mapMarkers,
    Function onSearchButtonPressed,
    Function collapseBottomDrawerFunc,
  }) {
    searchService.searchButtonController = this;
    _mapMarkers = mapMarkers;
    _onSearchButtonPressed = onSearchButtonPressed;
    _collapseBottomDrawer = collapseBottomDrawerFunc;
    _button = _searchButton();
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

  void showUnfilterButton(String filterName) {
    _collapseBottomDrawer();
    _button = _unfilterButton(filterName);
    return notifyListeners();
  }

  void _restoreToDefault() {
    _mapMarkers.resetMarkers();
    _button = _searchButton();
    return notifyListeners();
  }
}
