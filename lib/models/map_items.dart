import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:kampus_sggw/models/map_item.dart';
import 'package:kampus_sggw/models/types/map_item_types/map_item_types.dart';
import 'package:get_storage/get_storage.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:kampus_sggw/logic/object_function_group.dart';
import 'package:kampus_sggw/models/types/service_types/service_types.dart';
part 'map_items.g.dart';

@JsonSerializable()
class MapItems extends ChangeNotifier {
  static final storage = GetStorage();

  List<MapItem>? mapItems;
  MapItems(
    this.mapItems,
  );

  static Future<MapItems> load() async {
    MapItems mapItems = await _loadFromJson();
    mapItems._bindItemWithTypes(
      await MapItemTypes.loadFromJson(),
      await ServiceTypes.loadFromJson(),
    );
    return mapItems;
  }

  factory MapItems.fromJson(Map<String, dynamic> json) =>
      _$MapItemsFromJson(json);

  Set<MapItem> filterByFunction(ObjectFunctionGroup? functionGroup) =>
      {}..addAll(
          mapItems!.where((item) => item.doesItemFulfilFunction(functionGroup)));

  List<MapItem> getItemsMappedWithId(List<int?> itemsIds) => []..addAll(
      itemsIds.map((id) => mapItems!.firstWhere((item) => item.id == id)));

  void _bindItemWithTypes(
          MapItemTypes mapItemTypes, ServiceTypes serviceTypes) =>
      mapItems!
          .forEach((item) => item.initializeTypes(mapItemTypes, serviceTypes));

  static Future<MapItems> _loadFromJson() async {
    Map<String, dynamic> mapItemsMap = jsonDecode(_getJsonString()!);
    MapItems mapItems = MapItems.fromJson(mapItemsMap);
    return mapItems;
  }

  static String? _getJsonString() => storage.read('map_items_content');
}
