import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:kampus_sggw/logic/icon_map.dart';
import 'package:kampus_sggw/models/map_object_application.dart';

abstract class TypeFromJSON {
  String name;
  int materialIconID;
  String materialIconName;
  MapObjectApplication objectApplication;
  @JsonKey(ignore: true)
  IconData iconData;

  TypeFromJSON({
    this.name,
    this.materialIconID,
    this.materialIconName,
    this.objectApplication,
  }) {
    _setIconData();
  }

  void _setIconData() => iconData = iconMap[materialIconName];

  // void _setIcon() {
  //   materialIcon = Icon(IconData(materialIconID, fontFamily: 'MaterialIcons'));
  // }
}
