import 'package:json_annotation/json_annotation.dart';

part 'department.g.dart';

@JsonSerializable()
class Department {
  String id;
  String name;
  String? url;
  String? description;

  Department({
    required this.id,
    required this.name,
    this.url,
    this.description,
  });

  factory Department.fromJson(Map<String, dynamic> json) =>
      _$DepartmentFromJson(json);
}
