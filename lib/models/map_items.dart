import 'package:kampus_sggw/models/map_item.dart';
import 'package:flutter/services.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:kampus_sggw/models/service.dart';
import 'package:fuzzy/fuzzy.dart';
part 'map_items.g.dart';

@JsonSerializable()
class MapItems {
  List<MapItem> mapItems;
  @JsonKey(ignore: true)
  Map<MapItem, Fuzzy> fuzzySetItemMap;
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
    List<MapItem> similarItems = findItemsByQuery(query);
    return similarItems.length > 0 ? similarItems[0] : null;
  }

  List<MapItem> findItemsByQuery(String query) {
    Map<MapItem, double> similarityMap =
        _getSimilarityMapForEachItem(query.toLowerCase());
    return _getMostSimilarMapItems(similarityMap);
  }

  void generateFuzzyStringSetForMapItems() {
    mapItems.forEach((item) {
      item.generateFuzzySet();
    });
  }

  Map<MapItem, double> _getSimilarityMapForEachItem(String query) {
    Map<MapItem, double> similarityMap = <MapItem, double>{};
    mapItems.forEach(
      (item) {
        var similarity = item.searchingSet.search(query);
        if (similarity.length > 0) {
          similarityMap[item] = similarity[0].score;
        }
      },
    );
    return similarityMap;
  }

  List<MapItem> _getMostSimilarMapItems(Map<MapItem, double> similarityMap) {
    List<MapItem> items = similarityMap.keys.toList();
    items.sort((a, b) => similarityMap[a].compareTo(similarityMap[b]));
    return items.take(6).toList();
  }
}
