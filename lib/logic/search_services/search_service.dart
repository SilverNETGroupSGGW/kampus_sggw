import 'package:flutter/material.dart';
import 'package:kampus_sggw/logic/search_services/markers_service.dart';
import 'package:kampus_sggw/models/map_item.dart';

class SearchService extends ChangeNotifier {
  MarkersService _markersService;
  SearchService({markersService}) {
    _markersService = markersService;
  }

  void search(MapItem mapItem) => _markersService.showSearchedItem(mapItem);
}
