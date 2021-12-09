import 'package:json_annotation/json_annotation.dart';
import 'package:kampus_sggw/logic/object_function_group.dart';
import 'package:kampus_sggw/models/types/type_from_json.dart';

part 'service_type.g.dart';

@JsonSerializable()
class ServiceType extends TypeFromJson {
  @JsonKey(defaultValue: '0xFF9E9E9E')
  String? color;
  int? _colorInHex;

  ServiceType({
    String? name,
    String? materialIconName,
    ObjectFunctionGroup? functionGroup,
    this.color,
  }) : super(
          name: name,
          materialIconName: materialIconName,
          functionGroup: functionGroup,
        ) {
    _setColorInHex();
  }
  int? get colorInHex => _colorInHex;

  factory ServiceType.fromJson(Map<String, dynamic> json) =>
      _$ServiceTypeFromJson(json);

  void _setColorInHex() => _colorInHex = int.parse(color!);
}
