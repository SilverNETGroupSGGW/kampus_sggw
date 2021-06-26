import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:kampus_sggw/models/map_item.dart';
import 'package:kampus_sggw/models/map_items.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'user_history.g.dart';

@JsonSerializable()
class UserHistory extends ChangeNotifier {
  @JsonKey(defaultValue: 6)
  int buffer;
  @JsonKey(defaultValue: <int>[])
  List<int> itemsIds;

  UserHistory({this.buffer, this.itemsIds});

  factory UserHistory.fromJson(Map<String, dynamic> json) =>
      _$UserHistoryFromJson(json);

  Map<String, dynamic> toJson() => _$UserHistoryToJson(this);

  @protected
  List<MapItem> updateMapItems(MapItems mapItems) =>
      mapItems.getItems(itemsIds).reversed.toList();

  @protected
  void addItem(MapItem mapItem) {
    _putAtFirstPosition(mapItem);
    itemsIds.add(mapItem.id);
    _trimListToBuffer();
  }

  void _trimListToBuffer() {
    if (itemsIds.length > buffer) {
      itemsIds.removeRange(0, 1);
    }
  }

  void _putAtFirstPosition(MapItem mapItem) {
    deleteItem(mapItem);
  }

  @protected
  void deleteItem(MapItem mapItem) {
    itemsIds.removeWhere((item) => item == mapItem.id);
  }

  @protected
  void saveToJson(String sharedPrefKey) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String jsonString = jsonEncode(this.toJson());
    await sharedPreferences.setString(sharedPrefKey, jsonString);
  }

  @protected
  static Future<String> getJSONString(String sharedPrefKey) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(sharedPrefKey) ?? "{}";
  }
}
