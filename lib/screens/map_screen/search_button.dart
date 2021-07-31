import 'package:flutter/material.dart';
import 'package:kampus_sggw/screens/map_screen/map_markers.dart';

class SearchButton extends ChangeNotifier {
  FloatingActionButton _button;
  Function _onSearchButtonPressed;
  Function _collapseBottomDrawer;
  MapMarkers _mapMarkers;

  FloatingActionButton get button => _button;

  SearchButton({onPressed, mapMarkers, collapseBottomDrawer}) {
    _collapseBottomDrawer = collapseBottomDrawer;
    _mapMarkers = mapMarkers;
    _onSearchButtonPressed = onPressed;
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
