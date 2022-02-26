import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:kampus_sggw/json_entities/map_item_type.dart';
part 'map_item_types.g.dart';

@JsonSerializable()
class MapItemTypes {
  @JsonKey(defaultValue: <MapItemType>[])
  List<MapItemType> mapItemTypes;

  MapItemTypes({
    required this.mapItemTypes,
  });

  static Future<MapItemTypes> loadFromJson(jsonString) async {
    Map<String, dynamic> mapItemTypesMap = jsonDecode(await jsonString);
    return MapItemTypes.fromJson(mapItemTypesMap);
  }

  factory MapItemTypes.fromJson(Map<String, dynamic> json) =>
      _$MapItemTypesFromJson(json);
}
