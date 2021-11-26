import 'package:json_annotation/json_annotation.dart';
import 'package:kampus_sggw/models/map_object_application.dart';
import 'package:kampus_sggw/models/types/type_from_json.dart';

part 'service_type.g.dart';

@JsonSerializable()
class ServiceType extends TypeFromJSON {
  @JsonKey(defaultValue: '0xFF9E9E9E')
  String color;
  int _colorInHex;

  ServiceType({
    String name,
    String materialIconName,
    MapObjectApplication objectApplication,
    this.color,
  }) : super(
          name: name,
          materialIconName: materialIconName,
          objectApplication: objectApplication,
        ) {
    _setColorInHex();
  }
  int get colorInHex => _colorInHex;

  factory ServiceType.fromJson(Map<String, dynamic> json) =>
      _$ServiceTypeFromJson(json);

  void _setColorInHex() => _colorInHex = int.parse(color);
}
