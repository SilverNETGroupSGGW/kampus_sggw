import 'package:kampus_sggw/models/category.dart';
import 'package:kampus_sggw/models/location.dart';
import 'package:kampus_sggw/models/service.dart';
import 'package:json_annotation/json_annotation.dart';
part 'map_item.g.dart';

enum MapItemType {
  facultyBuilding,
  administrationBuilding,
  sportsFacility,
  store,
  food,
  library,
  parking,
  transport,
  finance,
  dormitories,
  kindergarten,
  monument,
  medicine,
}

@JsonSerializable()
class MapItem {
  int id;
  Location geoLocation;
  String name;
  String description;
  String url;
  MapItemType type;
  String photoPath;
  double minScale;
  DateTime lastModified;
  List<String> gallery;
  List<Service> services;
  List<Category> categories;
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

  bool itemContainsService(ServiceType wantedService) => services != null
      ? services.any((service) => service.type == wantedService)
      : false;
}
