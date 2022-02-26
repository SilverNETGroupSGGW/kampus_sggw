import 'package:json_annotation/json_annotation.dart';
import 'package:kampus_sggw/json_entities/faculty_service.dart';
part 'faculty.g.dart';

@JsonSerializable()
class Faculty {
  String id;
  String name;
  String? url;
  String? description;
  @JsonKey(defaultValue: <FacultyService>[])
  List<FacultyService> facultyServices;

  Faculty({
    required this.id,
    required this.name,
    this.url,
    this.description,
    required this.facultyServices,
  });

  factory Faculty.fromJson(Map<String, dynamic> json) =>
      _$FacultyFromJson(json);
}
