import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:kampus_sggw/json_entities/map_item.dart';
part 'map_items.g.dart';

@JsonSerializable()
class MapItems {
  //static final storage = GetStorage();
  List<MapItem> mapItems;

  MapItems({
    required this.mapItems,
  });

  factory MapItems.fromJson(Map<String, dynamic> json) =>
      _$MapItemsFromJson(json);

  // static Future<MapItems> _loadFromJson() async {
  //   Map<String, dynamic> mapItemsMap = jsonDecode(_getJsonString()!);
  //   MapItems mapItems = MapItems.fromJson(mapItemsMap);
  //   return mapItems;
  // }

  //static String _getJsonString() => storage.read('map_items_content');
}
