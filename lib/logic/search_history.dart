import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'search_history.g.dart';

@JsonSerializable()
class SearchHistory {
  @JsonKey(defaultValue: 6)
  final int buffer;
  @JsonKey(defaultValue: <String>[])
  List<String> searchHistory;

  SearchHistory(this.buffer, this.searchHistory);
  factory SearchHistory.fromJson(Map<String, dynamic> json) =>
      _$SearchHistoryFromJson(json);
  Map<String, dynamic> toJson() => _$SearchHistoryToJson(this);

  Set<String> filterSearchTerms({String query}) {
    if (query != null && query.isNotEmpty) {
      return searchHistory.reversed
          .where((term) => term.startsWith(query))
          .toSet();
    } else {
      return searchHistory.reversed.toSet();
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

  void save() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String jsonString = jsonEncode(this.toJson());
    await sharedPreferences.setString('searchHistory', jsonString);
  }

  static Future<String> getJsonSting() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString('searchHistory') ?? "{}";
  }
}
