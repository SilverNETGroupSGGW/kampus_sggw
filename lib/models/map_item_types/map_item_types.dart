import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:kampus_sggw/models/map_item_types/map_item_type.dart';
part 'map_item_types.g.dart';

@JsonSerializable()
class MapItemTypes {
  List<MapItemType> mapItemTypes;
  MapItemTypes(
    this.mapItemTypes,
  );

  MapItemType getTypeByName(String typeName) {
    print("arg " + typeName);

    MapItemType mitype =
        mapItemTypes.firstWhere((type) => type.name == typeName);
    print("found type " + mitype.name);
    return mitype;
  }

  static Future<MapItemTypes> loadFromJSON() async {
    Map<String, dynamic> mapItemTypesMap = jsonDecode(await _getJsonSting());
    return MapItemTypes.fromJson(mapItemTypesMap);
  }

  factory MapItemTypes.fromJson(Map<String, dynamic> json) =>
      _$MapItemTypesFromJson(json);

  static Future<String> _getJsonSting() {
    return rootBundle.loadString('assets/json/map_item_types.json');
  }
}
