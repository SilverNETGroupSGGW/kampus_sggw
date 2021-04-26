import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:kampus_sggw/models/map_items.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'visited_items.g.dart';

@JsonSerializable()
class VisitedItems {
  @JsonKey(defaultValue: 6)
  int buffer;
  @JsonKey(defaultValue: <int>[])
  List<int> visitedItemsIds;
  VisitedItems(this.buffer, this.visitedItemsIds);
  factory VisitedItems.fromJson(Map<String, dynamic> json) =>
      _$VisitedItemsFromJson(json);
  Map<String, dynamic> toJson() => _$VisitedItemsToJson(this);

  List<String> getVisitedItemsNames(MapItems mapItems) =>
      mapItems.getItemsNames(visitedItemsIds).reversed.toList();

  void addItem(int id) {
    if (visitedItemsIds.contains(id)) {
      deleteItem(id);
    }
    visitedItemsIds.add(id);
    if (visitedItemsIds.length > buffer) {
      visitedItemsIds.removeRange(0, 1);
    }
  }

  void deleteItem(int id) {
    visitedItemsIds.removeWhere((i) => i == id);
  }

  void save() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String jsonString = jsonEncode(this.toJson());
    await sharedPreferences.setString('visitedItems', jsonString);
  }

  static Future<String> getJsonSting() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString('visitedItems') ?? "{}";
  }
}
