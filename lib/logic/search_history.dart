import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:kampus_sggw/logic/user_history.dart';
import 'package:kampus_sggw/models/map_item.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'search_history.g.dart';

@JsonSerializable()
class SearchHistory extends UserHistory {
  @JsonKey(ignore: true)
  List<MapItem> _searchedItems;

  SearchHistory({int buffer, List<int> itemsIds})
      : super(buffer: buffer, itemsIds: itemsIds);

  factory SearchHistory.fromJson(Map<String, dynamic> json) =>
      _$SearchHistoryFromJson(json);

  Map<String, dynamic> toJson() => _$SearchHistoryToJson(this);

  List<MapItem> filterSearchHistory({String query}) {
    if (query != null && query.isNotEmpty) {
      return _getItemsWhichNameStartsWith(query);
    } else {
      return _searchedItems;
    }
  }

  @override
  List<MapItem> updateMapItems(BuildContext context) {
    _searchedItems = super.updateMapItems(context);
    return _searchedItems;
  }

  void save() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String jsonString = jsonEncode(this.toJson());
    await sharedPreferences.setString('searchHistory', jsonString);
  }

  static Future<String> getJsonSting() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString('searchHistory') ?? "{}";
  }

  List<MapItem> _getItemsWhichNameStartsWith(String query) {
    return _searchedItems.where((item) => item.name.startsWith(query)).toList();
  }
}
