import 'package:json_annotation/json_annotation.dart';
import 'package:kampus_sggw/json_entities/building_service.dart';
import 'package:kampus_sggw/json_entities/faculty.dart';
import 'package:kampus_sggw/json_entities/geo_location.dart';
import 'package:kampus_sggw/json_entities/institute.dart';
import 'package:kampus_sggw/json_entities/office.dart';
part 'map_item.g.dart';

@JsonSerializable()
class MapItem {
  String id;
  GeoLocation geoLocation;
  String name;
  String? description;
  String type;
  @JsonKey(defaultValue: <BuildingService>[])
  List<BuildingService> buildingService;
  @JsonKey(defaultValue: <Faculty>[])
  List<Faculty> faculties;
  @JsonKey(defaultValue: <Institute>[])
  List<Institute> institutes;
  @JsonKey(defaultValue: <Office>[])
  List<Office> offices;

  MapItem({
    required this.id,
    required this.geoLocation,
    required this.name,
    this.description,
    required this.type,
    required this.buildingService,
    required this.faculties,
    required this.institutes,
    required this.offices,
  });

  factory MapItem.fromJson(Map<String, dynamic> json) =>
      _$MapItemFromJson(json);
}
