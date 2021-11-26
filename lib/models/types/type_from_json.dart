import 'package:flutter/material.dart';
import 'package:kampus_sggw/logic/icon_map.dart';
import 'package:kampus_sggw/models/map_object_application.dart';

abstract class TypeFromJSON {
  String name;
  String materialIconName;
  MapObjectApplication objectApplication;
  IconData _iconData;

  TypeFromJSON({
    this.name,
    this.materialIconName,
    this.objectApplication,
  }) {
    _setIconData();
  }
  IconData get iconData => _iconData;

  void _setIconData() => _iconData = iconMap[materialIconName];
}
