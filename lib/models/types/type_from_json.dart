import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:kampus_sggw/logic/maps/icon_map.dart';
import 'package:kampus_sggw/logic/object_function_group.dart';

@JsonSerializable()
abstract class TypeFromJson {
  String? name;
  String? materialIconName;
  ObjectFunctionGroup? functionGroup;
  IconData? _iconData;

  TypeFromJson({
    this.name,
    this.materialIconName,
    this.functionGroup,
  }) {
    _setIconData();
  }
  IconData? get iconData => _iconData;

  void _setIconData() => _iconData = iconMap[materialIconName!];
}
