import 'package:flutter/services.dart';

import 'map_item.dart';
import 'map_item_type.dart';
import 'package:json_annotation/json_annotation.dart';
part 'map_items.g.dart';

class MapItems {
  List<MapItem> mapItems;
  MapItems(
    this.mapItems,
  );
  List<MapItem> filter(List<MapItemType> types) => mapItems.where((element) => types.contains(element.type));
  factory MapItems.fromJson(Map<String, dynamic> json) => _$MapItemsFromJson(json);

  //static Future<String> getJson() {
  //return rootBundle.loadString('map_items.json');
//}
}
