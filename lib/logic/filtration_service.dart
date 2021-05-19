import 'dart:async';
import 'package:kampus_sggw/logic/event_parameters/search_event_param.dart';
import 'package:kampus_sggw/logic/event_parameters/update_markers_event_param.dart';
import 'package:kampus_sggw/logic/stream_service.dart';
import 'package:kampus_sggw/models/map_item.dart';
import 'package:kampus_sggw/models/map_items.dart';
import 'event_parameters/filter_by_function_event_param.dart';

class FiltrationService {
  final MapItems mapItems;
  StreamService _filterByFunctionEvent;
  StreamService _searchWithQueryEvent;
  StreamService _filterMarkersEvent;
  StreamService _unfilterMarkersEvent;
  StreamService _searchWithNameEvent;
  StreamService _searchSuggestionEvent;
  StreamService _manageSearchHistoryEvent;
  StreamSubscription _filterByFunctionListener;
  StreamSubscription _searchWithQueryListener;
  StreamSubscription _searchWithNameListener;
  final Function onNoItemFound;
  FiltrationService({this.mapItems, this.onNoItemFound}) {
    _initializeStreamServices();
    _initializeListeners();
  }

  StreamService get filterByFunctionEvent => _filterByFunctionEvent;
  StreamService get searchWithQueryEvent => _searchWithQueryEvent;
  StreamService get filterMarkersEvent => _filterMarkersEvent;
  StreamService get unfilterMarkersEvent => _unfilterMarkersEvent;
  StreamService get searchWithNameEvent => _searchWithNameEvent;
  StreamService get searchSuggestionEvent => _searchSuggestionEvent;
  StreamService get manageSearchHistoryEvent => _manageSearchHistoryEvent;

  void _initializeListeners() {
    _filterByFunctionListener = _filterByFunctionEvent
        .listen((filterEventParam) => _filterItemsByFunction(filterEventParam));
    _searchWithQueryListener = _searchWithQueryEvent
        .listen((searchEventParam) => _filterItemsByQuery(searchEventParam));
    _searchWithNameListener = _searchWithNameEvent
        .listen((mapItem) => _triggerInteractiveMap(mapItem.name, [mapItem]));
  }

  void _filterItemsByFunction(FilterByFunctionEventParam filterEventParam) {
    List<MapItem> filteredMapItems = _getFilteredItems(filterEventParam);
    _triggerInteractiveMap(filterEventParam.filterName, filteredMapItems);
  }

  void _filterItemsByQuery(SearchEventParam searchEventParam) {
    if (searchEventParam.isFinal) {
      _finalQuerySearch(searchEventParam.query);
    } else {
      _suggestSearches(searchEventParam.query);
    }
  }

  void _suggestSearches(String query) {
    List<MapItem> suggestedItems = mapItems.findItemsByQuery(query);
    // TODO : reduce number of suggested items to 6!
    Set<String> suggestedItemsNames = suggestedItems.map((e) => e.name).toSet();
    _searchSuggestionEvent.trigger(param: suggestedItemsNames);
  }

  void _finalQuerySearch(String query) {
    MapItem queriedItem = mapItems.findItemByQuery(query);
    if (queriedItem != null) {
      _manageSearchHistoryEvent.trigger(param: queriedItem.name);
      _triggerInteractiveMap(query, [queriedItem]);
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

  void _initializeStreamServices() {
    _filterByFunctionEvent = StreamService();
    _searchWithQueryEvent = StreamService();
    _filterMarkersEvent = StreamService();
    _unfilterMarkersEvent = StreamService();
    _searchWithNameEvent = StreamService();
    _searchSuggestionEvent = StreamService();
    _manageSearchHistoryEvent = StreamService();
  }

  void dispose() {
    _filterByFunctionListener.cancel();
    _searchWithQueryListener.cancel();
    _searchWithNameListener.cancel();
    _filterByFunctionEvent.dispose();
    _searchWithQueryEvent.dispose();
    _filterMarkersEvent.dispose();
    _unfilterMarkersEvent.dispose();
    _searchWithNameEvent.dispose();
    _manageSearchHistoryEvent.dispose();
  }
}
