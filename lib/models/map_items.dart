import 'package:kampus_sggw/models/map_item.dart';
import 'package:flutter/services.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:kampus_sggw/models/service.dart';
import 'package:string_similarity/string_similarity.dart';
part 'map_items.g.dart';

@JsonSerializable()
class MapItems {
  List<MapItem> mapItems;
  MapItems(
    this.mapItems,
  );

  Set<MapItem> filterItemsByItsServices(List<ServiceType> serviceTypes) {
    Set<MapItem> filteredItems = {};
    mapItems.forEach((item) {
      if (item.containsAtLeastOneServiceType(serviceTypes)) {
        filteredItems.add(item);
      }
    });
    return filteredItems;
  }

  Set<MapItem> filterItemsByItsType(List<MapItemType> itemTypes) {
    Set<MapItem> filteredItems = {};
    mapItems.forEach((item) {
      if (itemTypes.contains(item.type)) {
        filteredItems.add(item);
      }
    });
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

  MapItem findItemByQuery(String query) {
    query = query.toLowerCase();
    return mapItems.firstWhere((item) => item.name.toLowerCase() == query,
        orElse: () => null);
  }

  List<MapItem> findItemsByQuery(String query) {
    query = query.toLowerCase();
    Map<MapItem, double> similarityMap = <MapItem, double>{};

    mapItems.forEach(
      (item) {
        var similarity = item.name.similarityTo(query);
        print(item.name + ": " + similarity.toString());

        if(similarity > 0) {
          similarityMap[item] = similarity;
        }
      },
    );
    List<MapItem> items = (similarityMap.keys.toList());
    items.sort((a,b) => similarityMap[a].compareTo(similarityMap[b]));
    return items;
  }
}
