import 'dart:async';

import 'package:kampus_sggw/logic/event_parameters/search_event_param.dart';
import 'package:kampus_sggw/logic/event_parameters/update_markers_event_param.dart';
import 'package:kampus_sggw/logic/stream_service.dart';
import 'package:kampus_sggw/models/map_item.dart';
import 'package:kampus_sggw/models/map_items.dart';

import 'event_parameters/filter_by_function_event_param.dart';

class FiltrationService {
  final MapItems mapItems;
  final StreamService filterByFunctionEvent = StreamService();
  final StreamService searchWithQueryEvent = StreamService();
  final StreamService filterMarkersEvent = StreamService();
  final StreamService unfilterMarkersEvent = StreamService();
  final StreamService searchWithNameEvent = StreamService();
  StreamSubscription _filterByFunctionListener;
  StreamSubscription _searchWithQueryListener;
  StreamSubscription _searchWithNameListener;
  final Function onNoItemFound;
  FiltrationService({this.mapItems, this.onNoItemFound}) {
    _initializeListeners();
  }

  void _initializeListeners() {
    _filterByFunctionListener = filterByFunctionEvent
        .listen((filterEventParam) => _filterItemsByFunction(filterEventParam));
    _searchWithQueryListener = searchWithQueryEvent
        .listen((searchEventParam) => _filterItemsByQuery(searchEventParam));
    _searchWithNameListener = searchWithNameEvent
        .listen((mapItem) => _triggerInteractiveMap(mapItem.name, [mapItem]));
  }

  void _filterItemsByFunction(FilterByFunctionEventParam filterEventParam) {
    List<MapItem> filteredMapItems = _getFilteredItems(filterEventParam);
    _triggerInteractiveMap(filterEventParam.filterName, filteredMapItems);
  }

  void _filterItemsByQuery(SearchEventParam searchEventParam) {
    MapItem queriedItem = mapItems.findItemByQuery(searchEventParam.query);
    if (queriedItem != null) {
      _triggerInteractiveMap(searchEventParam.query, [queriedItem]);
    } else {
      onNoItemFound();
    }
  }

  void _triggerInteractiveMap(
      String filterName, List<MapItem> filteredMapItems) {
    UpdateMarkersEventParam updateEventParam = UpdateMarkersEventParam(
        filterName: filterName, filteredMapItems: filteredMapItems);
    filterMarkersEvent.trigger(param: updateEventParam);
  }

  List<MapItem> _getFilteredItems(FilterByFunctionEventParam filterByFunction) {
    Set<MapItem> itemsFilteredByType = {};
    Set<MapItem> itemsFilteredByServices = {};
    if (filterByFunction.mapItemTypes != null) {
      itemsFilteredByType =
          mapItems.filterItemsByItsType(filterByFunction.mapItemTypes);
    }
    if (filterByFunction.serviceTypes != null) {
      itemsFilteredByServices =
          mapItems.filterItemsByItsServices(filterByFunction.serviceTypes);
    }
    return itemsFilteredByType.union(itemsFilteredByServices).toList();
  }

  void dispose() {
    _filterByFunctionListener.cancel();
    _searchWithQueryListener.cancel();
    _searchWithNameListener.cancel();
    filterByFunctionEvent.dispose();
    searchWithQueryEvent.dispose();
    filterMarkersEvent.dispose();
    unfilterMarkersEvent.dispose();
    searchWithNameEvent.dispose();
  }
}
