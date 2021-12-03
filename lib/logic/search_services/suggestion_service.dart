import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:kampus_sggw/logic/event_parameters/suggested_item.dart';
import 'package:kampus_sggw/logic/matching_to_search_query.dart';
import 'package:kampus_sggw/models/map_items.dart';

class SuggestionService extends ChangeNotifier {
  MapItems? _mapItems;
  late List<SuggestedItem> _current;

  UnmodifiableListView<SuggestedItem> get currentSuggestions =>
      UnmodifiableListView(_current);

  SuggestionService({mapItems}) {
    _mapItems = mapItems;
    _current = [];
  }

  void suggestItemsMatchingQuery(String query) {
    _current = MatchingToSearchQuery.findItemsMatchingQuery(_mapItems!, query);
    notifyListeners();
  }

  void resetSuggestions() {
    _current = [];
  }
}
