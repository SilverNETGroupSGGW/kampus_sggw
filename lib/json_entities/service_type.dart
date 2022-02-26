import 'package:json_annotation/json_annotation.dart';

part 'service_type.g.dart';

@JsonSerializable()
class ServiceType {
  String name;
  String materialIconName;
  @JsonKey(defaultValue: '0xFF9E9E9E')
  String color;

  ServiceType({
    required this.name,
    required this.materialIconName,
    required this.color,
  });

  factory ServiceType.fromJson(Map<String, dynamic> json) =>
      _$ServiceTypeFromJson(json);
}
