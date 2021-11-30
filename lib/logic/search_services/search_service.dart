import 'package:flutter/material.dart';
import 'package:kampus_sggw/models/map_item.dart';
import 'package:kampus_sggw/logic/controllers/map_markers_controller.dart';
import 'package:kampus_sggw/logic/controllers/search_button_controller.dart';

class SearchService extends ChangeNotifier {
  MapMarkersController? _mapMarkers;
  late SearchButtonController _searchButton;

  SearchService({MapMarkersController? mapMarkers}) {
    _mapMarkers = mapMarkers;
  }

  set searchButtonController(SearchButtonController value) =>
      _searchButton = value;

  void filter(String filterName, List<MapItem> filteredItems) {
    _mapMarkers!.updateMarkers(filteredItems);
    _searchButton.showUnfilterButton(filterName);
  }

  void showSearchedItem(MapItem item) => filter(item.name!, [item]);

  void resetMarkers() => _mapMarkers!.resetMarkers();
}
