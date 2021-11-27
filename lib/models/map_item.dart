import 'package:flutter/material.dart';
import 'package:fuzzy/fuzzy.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kampus_sggw/models/category.dart';
import 'package:kampus_sggw/models/location.dart';
import 'package:kampus_sggw/models/types/map_item_types/map_item_type.dart';
import 'package:kampus_sggw/models/types/map_item_types/map_item_types.dart';
import 'package:kampus_sggw/models/map_object_application.dart';
import 'package:kampus_sggw/models/service.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:kampus_sggw/models/types/service_types/service_types.dart';
part 'map_item.g.dart';

@JsonSerializable()
class MapItem {
  int id;
  Location geoLocation;
  String name;
  String description;
  String url;
  String type;
  String photoPath;
  double minScale;
  DateTime lastModified;
  List<String> gallery;
  List<Service> services;
  List<Category> categories;
  @JsonKey(ignore: true)
  Fuzzy _searchingSet;
  @JsonKey(ignore: true)
  MapItemType _mapItemType;

  MapItem({
    this.id,
    this.geoLocation,
    this.name,
    this.description,
    this.url,
    this.type,
    this.photoPath,
    this.minScale,
    this.lastModified,
    this.gallery,
    this.services,
    this.categories,
  });

  BitmapDescriptor get pinIcon => _mapItemType.pinIcon;
  IconData get iconData => _mapItemType.iconData;
  ObjectFunctionGroup get functionGroup => _mapItemType.functionGroup;
  Fuzzy get searchingSet => _searchingSet;

  factory MapItem.fromJson(Map<String, dynamic> json) =>
      _$MapItemFromJson(json);

  bool doesItemFulfilFunction(ObjectFunctionGroup functionGroup) =>
      (this.functionGroup == functionGroup ||
          _containsServiceFulfillingFunction(functionGroup));

  void generateFuzzySet() =>
      _searchingSet = _getFuse(_getWordsForComparisonWithSearchQuery());

  void initializeTypes(MapItemTypes mapItemTypes, ServiceTypes serviceTypes) {
    _setTypeForMapItem(mapItemTypes);
    _setTypesForAllServices(serviceTypes);
  }

  void _setTypeForMapItem(MapItemTypes mapItemTypes) =>
      _mapItemType = mapItemTypes.types[type];

  void _setTypesForAllServices(ServiceTypes serviceTypes) {
    _setTypesForServices(serviceTypes);
    _setTypesForServicesInCategories(serviceTypes);
  }

  void _setTypesForServices(ServiceTypes serviceTypes) {
    if (services != null) {
      for (var service in services) {
        service.setType(serviceTypes);
      }
    }
  }

  void _setTypesForServicesInCategories(ServiceTypes serviceTypes) {
    if (categories != null) {
      for (var category in categories) {
        category.setTypesForServices(serviceTypes);
      }
    }
  }

  bool _containsServiceFulfillingFunction(ObjectFunctionGroup functionGroup) =>
      services != null &&
      services.any((service) => service.functionGroup == functionGroup);

  List<String> _getWordsForComparisonWithSearchQuery() {
    List<String> wordsForComparison = [];
    wordsForComparison.addAll(_getInnerWords());
    wordsForComparison.addAll(_getWordsForComparisonInCategories());
    return wordsForComparison;
  }

  List<String> _getWordsForComparisonInCategories() {
    List<String> wordsForComparison = [];
    if (_categoriesExist()) {
      for (var cat in categories) {
        wordsForComparison.addAll(cat.getWordsForComparisonWithSearchQuery());
      }
    }
    return wordsForComparison;
  }

  List<String> _getInnerWords() =>
      description != null ? [name, description] : [name];

  bool _categoriesExist() => categories != null && categories.isNotEmpty;

  Fuzzy _getFuse(List<String> wordsForComparisonWithSearchQuery) {
    return Fuzzy(
      wordsForComparisonWithSearchQuery,
      options: FuzzyOptions(
        findAllMatches: true,
        tokenize: true,
        threshold: 0.5,
      ),
    );
  }
}
