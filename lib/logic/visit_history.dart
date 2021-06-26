import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:kampus_sggw/logic/JSON_services/loadable_JSON.dart';
import 'package:kampus_sggw/logic/JSON_services/storable_JSON.dart';
import 'package:kampus_sggw/logic/user_history.dart';
import 'package:kampus_sggw/models/map_item.dart';
part 'visit_history.g.dart';

@JsonSerializable()
class VisitHistory extends UserHistory with StorableJSON, LoadableJSON {
  VisitHistory({int buffer, List<int> itemsIds})
      : super(buffer: buffer, itemsIds: itemsIds);

  factory VisitHistory.fromJson(Map<String, dynamic> json) =>
      _$VisitHistoryFromJson(json);
  Map<String, dynamic> toJson() => _$VisitHistoryToJson(this);

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
    String jsonString = await LoadableJSON.getJSONString('visitHistory');
    Map<String, dynamic> map = jsonDecode(jsonString);
    return VisitHistory.fromJson(map);
  }
}
