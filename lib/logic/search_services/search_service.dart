import 'dart:async';
import 'package:flutter/material.dart';
import 'package:kampus_sggw/logic/event_parameters/search_event_param.dart';
import 'package:kampus_sggw/logic/search_services/markers_service.dart';
import 'package:kampus_sggw/logic/search_services/stream_service.dart';
import 'package:kampus_sggw/models/map_item.dart';
import 'package:kampus_sggw/models/map_items.dart';

class SearchService extends ChangeNotifier {
  MapItems _mapItems;
  MarkersService _markersService;
  StreamService _searchWithQueryEvent;
  StreamService _searchWithMapItemEvent;
  StreamService _searchSuggestionEvent;
  StreamService _manageSearchHistoryEvent;
  StreamSubscription _searchWithQueryListener;
  StreamSubscription _searchWithMapItemListener;
  Function onNoItemFound;
  //SearchService({mapItems, markersService, this.onNoItemFound}) {
  SearchService({mapItems, markersService}) {
    _mapItems = mapItems;
    _markersService = markersService;
    _initializeStreamServices();
    _initializeListeners();
  }

  StreamService get searchWithQueryEvent => _searchWithQueryEvent;
  StreamService get searchWithMapItemEvent => _searchWithMapItemEvent;
  StreamService get searchSuggestionEvent => _searchSuggestionEvent;
  StreamService get manageSearchHistoryEvent => _manageSearchHistoryEvent;

  void _initializeListeners() {
    _searchWithQueryListener = _searchWithQueryEvent
        .listen((searchEventParam) => _filterItemsByQuery(searchEventParam));
    _searchWithMapItemListener = _searchWithMapItemEvent
        .listen((mapItem) => _triggerInteractiveMap(mapItem.name, [mapItem]));
  }

  void _filterItemsByQuery(SearchEventParam searchEventParam) {
    if (searchEventParam.isFinal) {
      _finalQuerySearch(searchEventParam.query);
    } else {
      _suggestSearches(searchEventParam.query);
    }
  }

  void _suggestSearches(String query) =>
      _searchSuggestionEvent.trigger(param: _mapItems.findItemsByQuery(query));

  void _finalQuerySearch(String query) {
    MapItem queriedItem = _mapItems.findItemByQuery(query);
    if (queriedItem != null) {
      _manageSearchHistoryEvent.trigger(param: queriedItem.name);
      _triggerInteractiveMap(queriedItem.name, [queriedItem]);
    } else {
      onNoItemFound();
    }
  }

  void _triggerInteractiveMap(String filterName, List<MapItem> filteredItems) {
    _markersService.trigger(filterName, filteredItems);
  }

  void _initializeStreamServices() {
    _searchWithQueryEvent = StreamService();
    _searchWithMapItemEvent = StreamService();
    _searchSuggestionEvent = StreamService();
    _manageSearchHistoryEvent = StreamService();
  }

  void dispose() {
    _searchWithQueryListener.cancel();
    _searchWithMapItemListener.cancel();
    _searchWithQueryEvent.dispose();
    _searchWithMapItemEvent.dispose();
    _manageSearchHistoryEvent.dispose();
    super.dispose();
  }
}
