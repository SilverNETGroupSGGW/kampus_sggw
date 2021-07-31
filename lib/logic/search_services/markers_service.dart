import 'package:flutter/material.dart';
import 'package:kampus_sggw/models/map_item.dart';
import 'package:kampus_sggw/screens/map_screen/map_markers.dart';
import 'package:kampus_sggw/screens/map_screen/search_button.dart';

class MarkersService extends ChangeNotifier {
  MapMarkers _mapMarkers;
  SearchButton _searchButton;

  MarkersService({MapMarkers mapMarkers}) {
    _mapMarkers = mapMarkers;
  }

  set searchButton(SearchButton value) {
    _searchButton = value;
  }

  void filter(String filterName, List<MapItem> filteredItems) {
    _mapMarkers.updateMarkers(filteredItems);
    _searchButton.showUnfilterButton(filterName);
  }

  void showSearchedItem(MapItem item) {
    filter(item.name, [item]);
  }
}
