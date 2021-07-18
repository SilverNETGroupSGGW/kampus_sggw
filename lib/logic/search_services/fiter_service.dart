//import 'dart:async';

import 'package:flutter/material.dart';
import 'package:kampus_sggw/logic/event_parameters/filter_by_function_event_param.dart';
//import 'package:kampus_sggw/logic/event_parameters/markers_event_param.dart';
import 'package:kampus_sggw/logic/search_services/markers_service.dart';
//import 'package:kampus_sggw/logic/search_services/stream_service.dart';
import 'package:kampus_sggw/models/map_item.dart';
import 'package:kampus_sggw/models/map_items.dart';
import 'package:kampus_sggw/models/service.dart';

class FilterService extends ChangeNotifier {
  MapItems _mapItems;
  MarkersService _markersService;

  //StreamService _filterMapItemsEvent;
  //StreamSubscription _eventListener;

  FilterService({mapItems, markersService}) {
    _mapItems = mapItems;
    _markersService = markersService;
    //_filterMapItemsEvent = StreamService();
    //_eventListener = _filterMapItemsEvent
    //.listen((eventParam) => _filter(eventParam));
  }

  //void filterMapItems(FilterByFunctionEventParam eventParam) =>
  //_filterMapItemsEvent.trigger(param: eventParam);

  void filterMapItems(FilterByFunctionEventParam eventParam) {
    List<MapItem> filteredItems = _getFilteredItems(eventParam);
    _markersService.trigger(eventParam.filterName, filteredItems);
  }

  List<MapItem> _getFilteredItems(FilterByFunctionEventParam eventParam) {
    Set<MapItem> itemsFilteredByType = _filterByType(eventParam);
    Set<MapItem> itemsFilteredByServices = _filterByServices(eventParam);
    return itemsFilteredByType.union(itemsFilteredByServices).toList();
  }

  Set<MapItem> _filterByType(FilterByFunctionEventParam eventParam) {
    List<MapItemType> choosenTypes = eventParam.mapItemTypes;
    Set<MapItem> filteredItems = {};
    if (choosenTypes != null) {
      filteredItems = _mapItems.filterByType(choosenTypes);
    }
    return filteredItems;
  }

  Set<MapItem> _filterByServices(FilterByFunctionEventParam eventParam) {
    List<ServiceType> choosenServices = eventParam.serviceTypes;
    Set<MapItem> filteredItems = {};
    if (choosenServices != null) {
      filteredItems = _mapItems.filterByServices(choosenServices);
    }
    return filteredItems;
  }

  //void dispose() {
  //_eventListener.cancel();
  //_filterMapItemsEvent.dispose();
  //super.dispose();
  //}
}
