import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:kampus_sggw/models/types/types_from_json.dart';
import 'package:kampus_sggw/models/types/map_item_types/map_item_type.dart';
part 'map_item_types.g.dart';

@JsonSerializable()
class MapItemTypes extends TypesFromJson {
  MapItemTypes({List<MapItemType>? typesFromJson})
      : super(
          typesFromJson: typesFromJson,
        );

  static Future<MapItemTypes> loadFromJson() async {
    Map<String, dynamic> mapItemTypesMap = jsonDecode(await _getJsonSting());
    return MapItemTypes.fromJson(mapItemTypesMap);
  }

  factory MapItemTypes.fromJson(Map<String, dynamic> json) =>
      _$MapItemTypesFromJson(json);

  static Future<String> _getJsonSting() {
    return rootBundle.loadString('assets/json/map_item_types.json');
  }
}
