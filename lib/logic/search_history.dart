class SearchHistory {
  static final SearchHistory _instance = SearchHistory._internal();
  SearchHistory._internal();

  factory SearchHistory({int buffer}) {
    _instance.buffer = buffer;
    return _instance;
  }

  int buffer;
  List<String> _searchHistory = [];

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

  void deleteSearchTerm(String term) =>
      _searchHistory.removeWhere((t) => t == term);

  SearchHistory.fromJson(Map<String, dynamic> json)
      : _searchHistory = json['searchHistoryList'];

  Map<String, dynamic> toJson() => {
        'searchHistoryList': _searchHistory,
      };
}
