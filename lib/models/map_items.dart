import 'package:kampus_sggw/models/map_item.dart';
import 'package:flutter/services.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:kampus_sggw/models/service.dart';
import 'package:fuzzywuzzy/fuzzywuzzy.dart';
import 'package:fuzzy/fuzzy.dart';
part 'map_items.g.dart';

@JsonSerializable()
class MapItems {
  List<MapItem> mapItems;
  @JsonKey(ignore: true)
  Map<MapItem, Fuzzy> searchableStringsMap;
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
    query = query.toLowerCase();
    Map<MapItem, double> similarityMap = <MapItem, double>{};
    mapItems.forEach(
      (item) {
        var similarity = searchableStringsMap[item].search(query);
        if (similarity.length != 0) {
          similarityMap[item] = similarity[0].score;
        }
      },
    );
    List<MapItem> items = (similarityMap.keys.toList());
    items.sort((a, b) => similarityMap[a].compareTo(similarityMap[b]));
    return items.take(6).toList();
  }

  void generateSearchableStringMap() {
    searchableStringsMap = Map<MapItem, Fuzzy>();

    for (var item in mapItems) {
      List<String> searchableStrings = [];

      searchableStrings.add(item.name);
      if (item.description != null) {
        searchableStrings.add(item.description);
      }
      if (item.categories != null && item.categories.isNotEmpty) {
        for (var category in item.categories) {
          if (category.subCategories != null &&
              category.subCategories.isNotEmpty) {
            for (var subCategory in category.subCategories) {
              searchableStrings.add(subCategory.name);
              if (subCategory.description != null) {
                searchableStrings.add(subCategory.description);
                if (subCategory.subCategories != null &&
                    category.subCategories.isNotEmpty) {
                  for (var innerSubCategory in subCategory.subCategories) {
                    if (innerSubCategory.subCategories != null &&
                        innerSubCategory.subCategories.isNotEmpty) {
                      for (var innerInnerSubCategory
                          in innerSubCategory.subCategories) {
                        searchableStrings.add(innerInnerSubCategory.name);
                        if (innerInnerSubCategory.description != null) {
                          searchableStrings
                              .add(innerInnerSubCategory.description);
                        }
                      }
                    }
                  }
                }
              }
            }
          }
        }
      }
      var fuse = Fuzzy(
        searchableStrings,
        options: FuzzyOptions(
          findAllMatches: true,
          tokenize: true,
          threshold: 0.5,
        ),
      );
      searchableStringsMap[item] = fuse;
    }
  }
}
