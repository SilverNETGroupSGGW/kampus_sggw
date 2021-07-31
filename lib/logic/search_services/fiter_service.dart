import 'package:flutter/material.dart';
import 'package:kampus_sggw/logic/event_parameters/filtration_event_param.dart';
import 'package:kampus_sggw/logic/search_services/search_service.dart';
import 'package:kampus_sggw/models/map_item.dart';
import 'package:kampus_sggw/models/map_items.dart';
import 'package:kampus_sggw/models/service.dart';

class FilterService extends ChangeNotifier {
  MapItems _mapItems;
  SearchService _searchService;

  FilterService({mapItems, markersService}) {
    _mapItems = mapItems;
    _searchService = markersService;
  }

  void filterMapItems(FiltrationEventParam eventParam) {
    List<MapItem> filteredItems = _getFilteredItems(eventParam);
    _searchService.filter(eventParam.filterName, filteredItems);
  }

  List<MapItem> _getFilteredItems(FiltrationEventParam eventParam) {
    Set<MapItem> itemsFilteredByType = _filterByType(eventParam);
    Set<MapItem> itemsFilteredByServices = _filterByServices(eventParam);
    return itemsFilteredByType.union(itemsFilteredByServices).toList();
  }

  Set<MapItem> _filterByType(FiltrationEventParam eventParam) {
    List<MapItemType> choosenTypes = eventParam.mapItemTypes;
    Set<MapItem> filteredItems = {};
    if (choosenTypes != null) {
      filteredItems = _mapItems.filterByType(choosenTypes);
    }
    return filteredItems;
  }

  Set<MapItem> _filterByServices(FiltrationEventParam eventParam) {
    List<ServiceType> choosenServices = eventParam.serviceTypes;
    Set<MapItem> filteredItems = {};
    if (choosenServices != null) {
      filteredItems = _mapItems.filterByServices(choosenServices);
    }
    return filteredItems;
  }
}
