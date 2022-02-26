import 'package:json_annotation/json_annotation.dart';
import 'package:kampus_sggw/json_entities/department.dart';
part 'institute.g.dart';

@JsonSerializable()
class Institute {
  String id;
  String name;
  String? url;
  String? description;
  @JsonKey(defaultValue: <Department>[])
  List<Department> departments;

  Institute({
    required this.id,
    required this.name,
    this.url,
    this.description,
    required this.departments,
  });

  factory Institute.fromJson(Map<String, dynamic> json) =>
      _$InstituteFromJson(json);
}
