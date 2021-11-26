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
import 'package:kampus_sggw/models/types/service_types/service_type.dart';
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
  Fuzzy searchingSet;
  @JsonKey(ignore: true)
  MapItemType mapItemType;

  MapItem(
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
  );

  factory MapItem.fromJson(Map<String, dynamic> json) =>
      _$MapItemFromJson(json);

  bool doItemFulfilFunction(MapObjectApplication objectApplication) {
    print(id.toString() + " " + mapItemType.name);
    print(id.toString() +
        " " +
        mapItemType.objectApplication.toString() +
        " vs. " +
        objectApplication.toString());
    print(_containsServiceFulfillingFunction(objectApplication));
    return (mapItemType.objectApplication == objectApplication ||
        _containsServiceFulfillingFunction(objectApplication));
  }

  BitmapDescriptor pinIcon() => mapItemType.pinIcon;
  int iconID() => mapItemType.materialIconID;
  MapObjectApplication metaCategory() => mapItemType.objectApplication;

  void generateFuzzySet() {
    List<String> strings = [];
    _addData(strings);
    searchingSet = _getFuse(strings);
  }

  void initializeTypes(MapItemTypes mapItemTypes, ServiceTypes serviceTypes) {
    print("czy puste " + serviceTypes.types.isEmpty.toString());
    _setType(mapItemTypes);
    _setServicesType(serviceTypes);
  }

  void _setType(MapItemTypes mapItemTypes) =>
      mapItemType = mapItemTypes.getTypeByName(type);

  void _setServicesType(ServiceTypes serviceTypes) {
    if (services != null) {
      print("czy puste1 " + serviceTypes.types.isEmpty.toString());
      services.forEach((service) {
        service.setType(serviceTypes);
      });
    }
  }

  bool _containsServiceFulfillingFunction(
      MapObjectApplication objectApplication) {
    return services == null
        ? false
        : services.any((service) =>
            service.serviceType.objectApplication == objectApplication);
  }

  void _addInnerData(List<String> strings) {
    strings.add(name);
    if (description != null) {
      strings.add(description);
    }
  }

  bool _categoriesExist() =>
      categories != null && categories.isNotEmpty ? true : false;

  void _addData(List<String> strings) {
    _addInnerData(strings);
    if (_categoriesExist()) {
      for (var cat in categories) {
        cat.addData(strings);
      }
    }
  }

  Fuzzy _getFuse(List<String> strings) {
    return Fuzzy(
      strings,
      options: FuzzyOptions(
        findAllMatches: true,
        tokenize: true,
        threshold: 0.5,
      ),
    );
  }
}
