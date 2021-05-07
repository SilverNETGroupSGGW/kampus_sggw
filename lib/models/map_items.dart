import 'package:kampus_sggw/logic/filter_service.dart';
import 'package:kampus_sggw/models/map_item.dart';
import 'package:flutter/services.dart';
import 'package:json_annotation/json_annotation.dart';
part 'map_items.g.dart';

@JsonSerializable()
class MapItems {
  List<MapItem> mapItems;
  MapItems(
    this.mapItems,
  );
  List<MapItem> filter(FilterService filterService) {
    List<MapItem> filteredItems = [];
    if(filterService.mapItemType != null){
      filteredItems.addAll(mapItems.where((element) => element.type==filterService.mapItemType).toList());
    }
    if(filterService.serviceType != null){
      filteredItems.addAll(mapItems.where((mapItem) => mapItem.isItemContaingService(filterService.serviceType)).toList());
    }
    return filteredItems;
  }

  factory MapItems.fromJson(Map<String, dynamic> json) =>
      _$MapItemsFromJson(json);

  static Future<String> getJsonSting() {
    return rootBundle.loadString('assets/json/map_items.json');
  }

  List<MapItem> getItems(List<int> itemsIds) {
    List<MapItem> tmp = [];
    for (var id in itemsIds) {
      tmp.add(mapItems.firstWhere((element) => element.id == id));
    }
    return tmp;
  }
}
