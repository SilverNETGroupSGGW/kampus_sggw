import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:kampus_sggw/logic/icon_map.dart';
import 'package:kampus_sggw/models/map_object_application.dart';
import 'package:kampus_sggw/models/types/type_from_json.dart';

part 'service_type.g.dart';

@JsonSerializable()
class ServiceType extends TypeFromJSON {
  @JsonKey(defaultValue: '0xFF9E9E9E')
  String color;
  //String materialIconName;
  @JsonKey(ignore: true)
  int colorInHex;

  ServiceType({
    String name,
    int materialIconID,
    String materialIconName,
    MapObjectApplication objectApplication,
    this.color,
  }) : super(
          name: name,
          materialIconID: materialIconID,
          materialIconName: materialIconName,
          objectApplication: objectApplication,
        ) {
    _setColorInHex();
  }

  factory ServiceType.fromJson(Map<String, dynamic> json) =>
      _$ServiceTypeFromJson(json);

  void _setColorInHex() => colorInHex = int.parse(color);

  //void _setIconData() => iconData = iconMap[materialIconName];
}
