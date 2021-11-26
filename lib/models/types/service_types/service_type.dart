import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:kampus_sggw/logic/icon_map.dart';
import 'package:kampus_sggw/models/map_object_application.dart';
import 'package:kampus_sggw/models/types/type_from_json.dart';

part 'service_type.g.dart';

@JsonSerializable()
class ServiceType extends TypeFromJSON {
  int colorInInt;
  String materialIconName;
  //@JsonKey(ignore: true)
  //IconData iconData;

  ServiceType({
    String name,
    int materialIconID,
    String materialIconName,
    MapObjectApplication objectApplication,
    this.colorInInt,
  }) : super(
          name: name,
          materialIconID: materialIconID,
          objectApplication: objectApplication,
        ) {
    _setIconData();
  }

  factory ServiceType.fromJson(Map<String, dynamic> json) =>
      _$ServiceTypeFromJson(json);

  void _setIconData() {
    if (!iconMap.keys.contains(materialIconName)) {
      materialIconName = "default";
    }
  }
}
