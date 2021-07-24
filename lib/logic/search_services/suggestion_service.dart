import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:kampus_sggw/logic/search_services/suggested_item.dart';
import 'package:kampus_sggw/models/map_items.dart';

class SuggestionService extends ChangeNotifier {
  MapItems _mapItems;
  //StreamService _searchSuggestionEvent;
  List<SuggestedItem> _current;

  SuggestionService({mapItems}) {
    _mapItems = mapItems;
    _current = [];
    //_searchSuggestionEvent = StreamService();
  }

  //StreamService get searchSuggestionEvent => _searchSuggestionEvent;
  UnmodifiableListView<SuggestedItem> get currentSuggestions =>
      UnmodifiableListView(_current);

  void suggestItemsMatchingQuery(String query) {
    //_searchSuggestionEvent.trigger(param: _mapItems.findItemsByQuery(query));
    _current = _mapItems.findItemsByQuery(query);

    // TODO - is notify listeners nessesary?
    notifyListeners();
  }

  //void dispose() {
  //_searchSuggestionEvent.dispose();
  //super.dispose();
  //}
}
