import 'package:json_annotation/json_annotation.dart';

part 'faculty_service.g.dart';

@JsonSerializable()
class FacultyService {
  String id;
  String name;
  String? description;
  String type;

  FacultyService({
    required this.id,
    required this.name,
    this.description,
    required this.type,
  });

  factory FacultyService.fromJson(Map<String, dynamic> json) =>
      _$FacultyServiceFromJson(json);
}
