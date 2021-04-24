import 'category.dart';
import 'map_item.dart';
import 'service.dart';
import 'package:json_annotation/json_annotation.dart';
part 'building.g.dart';

@JsonSerializable()
class Building extends MapItem {
  List<Service> services;
  List<Category> categories;
  Building(
    id,
    geoLocation,
    name,
    description,
    url,
    type,
    photoPath,
    minScale,
    lastModified,
    gallery,
    this.services,
    this.categories,
  ) : super(
          id,
          geoLocation,
          name,
          description,
          url,
          type,
          photoPath,
          minScale,
          lastModified,
          gallery,
        );
  factory Building.fromJson(Map<String, dynamic> json) => _$BuildingFromJson(json);
}
