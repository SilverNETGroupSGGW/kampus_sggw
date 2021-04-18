import 'package:flutter/cupertino.dart';

class SearchHistory {
  int buffer;
  List<String> _searchHistory = [];
  SearchHistory({
    @required this.buffer,
  });

  List<String> filterSearchTerms(String filter) {
    if (filter != null && filter.isNotEmpty) {
      return _searchHistory.reversed
          .where((term) => term.startsWith(filter))
          .toList();
    } else {
      return _searchHistory.reversed.toList();
    }
  }

  void addSearchTerm(String term) {
    if (_searchHistory.contains(term)) {
      deleteSearchTerm(term);
    }
    _searchHistory.add(term);
    if (_searchHistory.length > buffer) {
      _searchHistory.removeRange(0, 1);
    }
  }

  void deleteSearchTerm(String term) =>_searchHistory.removeWhere((t) => t == term);
}
