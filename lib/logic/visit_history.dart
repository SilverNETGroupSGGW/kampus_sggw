import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:kampus_sggw/logic/user_history.dart';
import 'package:kampus_sggw/models/map_item.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'visit_history.g.dart';

@JsonSerializable()
class VisitHistory extends UserHistory {
  VisitHistory({int buffer, List<int> itemsIds})
      : super(buffer: buffer, itemsIds: itemsIds);

  factory VisitHistory.fromJson(Map<String, dynamic> json) =>
      _$VisitHistoryFromJson(json);
  Map<String, dynamic> toJson() => _$VisitHistoryToJson(this);

  @override
  List<MapItem> updateMapItems(BuildContext context) =>
      super.updateMapItems(context);

  void save() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String jsonString = jsonEncode(this.toJson());
    await sharedPreferences.setString('visitHistory', jsonString);
  }

  static Future<String> getJsonSting() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString('visitHistory') ?? "{}";
  }
}
