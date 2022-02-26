import 'package:json_annotation/json_annotation.dart';
part 'building_service.g.dart';

@JsonSerializable()
class BuildingService {
  String id;
  String name;
  String? description;
  String type;

  BuildingService({
    required this.id,
    required this.name,
    this.description,
    required this.type,
  });

  factory BuildingService.fromJson(Map<String, dynamic> json) =>
      _$BuildingServiceFromJson(json);
}
