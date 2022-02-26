import 'package:json_annotation/json_annotation.dart';
part 'office.g.dart';

@JsonSerializable()
class Office {
  String id;
  String name;
  String? url;
  String? description;

  Office({
    required this.id,
    required this.name,
    this.url,
    this.description,
  });

  factory Office.fromJson(Map<String, dynamic> json) => _$OfficeFromJson(json);
}
