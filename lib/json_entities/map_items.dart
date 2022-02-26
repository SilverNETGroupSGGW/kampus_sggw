import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:kampus_sggw/json_entities/map_item.dart';
part 'map_items.g.dart';

@JsonSerializable()
class MapItems {
  List<MapItem> mapItems;

  MapItems({
    required this.mapItems,
  });

  static Future<MapItems> loadFromJson(jsonString) async {
    Map<String, dynamic> mapItemsMap = jsonDecode(await jsonString);
    MapItems mapItems = MapItems.fromJson(mapItemsMap);
    return mapItems;
  }

  factory MapItems.fromJson(Map<String, dynamic> json) =>
      _$MapItemsFromJson(json);
}
