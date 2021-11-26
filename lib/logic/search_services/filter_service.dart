import 'package:flutter/material.dart';
import 'package:kampus_sggw/logic/event_parameters/filtration_event_param.dart';
import 'package:kampus_sggw/logic/search_services/search_service.dart';
import 'package:kampus_sggw/models/map_item.dart';
import 'package:kampus_sggw/models/map_items.dart';

class FilterService extends ChangeNotifier {
  MapItems _mapItems;
  SearchService _searchService;

  FilterService({mapItems, searchService}) {
    _mapItems = mapItems;
    _searchService = searchService;
  }

  void filterMapItems(FiltrationEventParam eventParam) {
    print("ObjectApplication " + eventParam.objectApplication.toString());
    List<MapItem> filteredItems = _getFilteredItems(eventParam);
    filteredItems
        .forEach((element) => {print("Filtered items " + element.toString())});

    _searchService.filter(eventParam.filterName, filteredItems);
  }

  List<MapItem> _getFilteredItems(FiltrationEventParam eventParam) {
    print("List<MapItem> _getFilteredItems(FiltrationEventParam eventParam)");
    return _mapItems.filterByFunction(eventParam.objectApplication).toList();
  }
}
