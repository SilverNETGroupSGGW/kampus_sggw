import 'package:flutter/services.dart';
import 'package:json_annotation/json_annotation.dart';
part 'search_history.g.dart';

@JsonSerializable()
class SearchHistory {
  @JsonKey(defaultValue: 6)
  final int buffer;
  @JsonKey(defaultValue: [])
  List<String> searchHistory;

  SearchHistory(this.buffer, this.searchHistory);
  factory SearchHistory.fromJson(Map<String, dynamic> json) =>
      _$SearchHistoryFromJson(json);
  Map<String, dynamic> toJson() => _$SearchHistoryToJson(this);

  List<String> filterSearchTerms(String filter) {
    if (filter != null && filter.isNotEmpty) {
      return searchHistory.reversed
          .where((term) => term.startsWith(filter))
          .toList();
    } else {
      return searchHistory.reversed.toList();
    }
  }

  void addSearchTerm(String term) {
    if (searchHistory.contains(term)) {
      deleteSearchTerm(term);
    }
    searchHistory.add(term);
    if (searchHistory.length > buffer) {
      searchHistory.removeRange(0, 1);
    }
  }

  void deleteSearchTerm(String term) =>
      searchHistory.removeWhere((t) => t == term);

  static Future<String> getJsonSting() {
    return rootBundle.loadString('assets/json/search_history.json');
  }
}
