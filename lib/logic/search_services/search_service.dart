import 'package:flutter/material.dart';
import 'package:kampus_sggw/models/map_item.dart';
import 'package:kampus_sggw/logic/map_markers_controller.dart';
import 'package:kampus_sggw/logic/search_button_controller.dart';

class SearchService extends ChangeNotifier {
  MapMarkersConroller _mapMarkers;
  SearchButtonController _searchButton;

  SearchService({MapMarkersConroller mapMarkers}) {
    _mapMarkers = mapMarkers;
  }

  set searchButtonController(SearchButtonController value) =>
      _searchButton = value;

  void filter(String filterName, List<MapItem> filteredItems) {
    _mapMarkers.updateMarkers(filteredItems);
    _searchButton.showUnfilterButton(filterName);
  }

  void showSearchedItem(MapItem item) => filter(item.name, [item]);

  void resetMarkers() => _mapMarkers.resetMarkers();
}
