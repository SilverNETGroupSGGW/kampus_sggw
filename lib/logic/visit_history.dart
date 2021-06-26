import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:kampus_sggw/logic/user_history.dart';
import 'package:kampus_sggw/models/map_item.dart';
import 'package:kampus_sggw/models/map_items.dart';
part 'visit_history.g.dart';

@JsonSerializable()
class VisitHistory extends UserHistory {
  VisitHistory({int buffer, List<int> itemsIds})
      : super(buffer: buffer, itemsIds: itemsIds);

  factory VisitHistory.fromJson(Map<String, dynamic> json) =>
      _$VisitHistoryFromJson(json);
  Map<String, dynamic> toJson() => _$VisitHistoryToJson(this);

  @override
  List<MapItem> updateMapItems(MapItems mapItems) =>
      super.updateMapItems(mapItems);

  void save() async {
    super.saveToJson('visitHistory');
  }

  @override
  void addItem(MapItem mapItem) {
    super.addItem(mapItem);
    save();
  }

  @override
  void deleteItem(MapItem mapItem) {
    super.deleteItem(mapItem);
    save();
  }

  static Future<VisitHistory> loadFromJSON() async {
    String jsonString = await UserHistory.getJSONString('visitHistory');
    Map<String, dynamic> map = jsonDecode(jsonString);
    return VisitHistory.fromJson(map);
  }
}
