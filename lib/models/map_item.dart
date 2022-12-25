import 'package:flutter/material.dart';
import 'package:fuzzy/fuzzy.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kampus_sggw/models/category.dart';
import 'package:kampus_sggw/models/location.dart';
import 'package:kampus_sggw/models/types/map_item_types/map_item_type.dart';
import 'package:kampus_sggw/models/types/map_item_types/map_item_types.dart';
import 'package:kampus_sggw/logic/object_function_group.dart';
import 'package:kampus_sggw/models/service.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:kampus_sggw/models/types/service_types/service_types.dart';
part 'map_item.g.dart';

@JsonSerializable()
class MapItem {
  int? id;
  Location? geoLocation;
  String? name;
  String? description;
  String? url;
  String? type;
  String? photoPath;
  double? minScale;
  DateTime? lastModified;
  @JsonKey(defaultValue: <String>[])
  List<String>? gallery;
  @JsonKey(defaultValue: <Service>[])
  List<Service>? services;
  @JsonKey(defaultValue: <Category>[])
  List<Category>? categories;
  Fuzzy? _searchingSet;
  MapItemType? _mapItemType;

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
  }) {
    _generateFuzzySet();
  }

  BitmapDescriptor? get pinIcon => _mapItemType!.pinIcon;
  IconData? get iconData => _mapItemType!.iconData;
  ObjectFunctionGroup? get functionGroup => _mapItemType!.functionGroup;
  Fuzzy? get searchingSet => _searchingSet;

  factory MapItem.fromJson(Map<String, dynamic> json) =>
      _$MapItemFromJson(json);

  void initializeTypes(MapItemTypes mapItemTypes, ServiceTypes serviceTypes) {
    _setTypeForMapItem(mapItemTypes);
    _setTypesForAllServices(serviceTypes);
  }

  bool doesItemFulfilFunction(ObjectFunctionGroup? functionGroup) =>
      (this.functionGroup == functionGroup ||
          _containsServiceFulfillingFunction(functionGroup));

  void _setTypeForMapItem(MapItemTypes mapItemTypes) =>
      _mapItemType = mapItemTypes.types[type] as MapItemType?;

  void _setTypesForAllServices(ServiceTypes serviceTypes) {
    _setTypesForServices(serviceTypes);
    _setTypesForServicesInCategories(serviceTypes);
  }

  void _setTypesForServices(ServiceTypes serviceTypes) =>
      services!.forEach((service) => service.setType(serviceTypes));

  void _setTypesForServicesInCategories(ServiceTypes serviceTypes) => categories!
      .forEach((category) => category.setTypesForServices(serviceTypes));

  bool _containsServiceFulfillingFunction(ObjectFunctionGroup? functionGroup) =>
      services!.any((service) => service.functionGroup == functionGroup);

  void _generateFuzzySet() =>
      _searchingSet = _getFuse(_getWordsToCompareWithSearchQuery());

  Set<String?> _getWordsToCompareWithSearchQuery() =>
      _getInnerWords().union(_getWordsForComparisonInCategories());

  Set<String?> _getWordsForComparisonInCategories() {
    Set<String?> words = {};
    categories!.forEach((category) =>
        words.addAll(category.getWordsForComparisonWithSearchQuery()));
    return words;
  }

  Set<String?> _getInnerWords() => {name, description};

  Fuzzy _getFuse(Set<String?> wordsForComparisonWithSearchQuery) {
    return Fuzzy(
      wordsForComparisonWithSearchQuery.toList(),
      options: FuzzyOptions(
        findAllMatches: true,
        tokenize: true,
        threshold: 0.5,
      ),
    );
  }
}
