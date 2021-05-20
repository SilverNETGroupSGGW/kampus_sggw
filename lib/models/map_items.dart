import 'package:kampus_sggw/logic/key_value.dart';
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

  void generateFuzzyStringSetForMapItems() {
    mapItems.forEach((item) {
      item.generateFuzzySet();
    });
  }

  List<MapItem> getItems(List<int> itemsIds) {
    List<MapItem> tmp = [];
    for (var id in itemsIds) {
      tmp.add(mapItems.firstWhere((element) => element.id == id));
    }
    return tmp;
  }

  MapItem findItemByQuery(String query) {
    List<KeyValue> similarItems = findItemsByQuery(query);
    return similarItems.length > 0 ? similarItems[0].key : null;
  }

  List<KeyValue> findItemsByQuery(String query) {
    List<KeyValue> similarityList =
        _getSimilarityMapForEachItem(query.toLowerCase());
    return _getMostSimilarMapItems(similarityList);
  }

  List<KeyValue> _getSimilarityMapForEachItem(String query) {
    List<KeyValue> similarityList = [];
    mapItems.forEach(
      (item) {
        var similarity = item.searchingSet.search(query);
        if (similarity.length > 0) {
          similarityList.add(
            KeyValue(
              key: item,
              value: similarity[0].item,
              similarity: similarity[0].score,
            ),
          );
        }
      },
    );
    return similarityList;
  }

  List<KeyValue> _getMostSimilarMapItems(List<KeyValue> similarityList) {
    similarityList.sort((a, b) => a.similarity.compareTo(b.similarity));
    return similarityList.take(6).toList();
  }
}
