import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:kampus_sggw/logic/platform_tools.dart';
import 'package:kampus_sggw/logic/object_function_group.dart';
import 'package:kampus_sggw/models/types/type_from_json.dart';
part 'map_item_type.g.dart';

@JsonSerializable()
class MapItemType extends TypeFromJson {
  String? pinIconPath;
  BitmapDescriptor? _pinIcon;

  MapItemType({
    String? name,
    String? materialIconName,
    ObjectFunctionGroup? functionGroup,
    this.pinIconPath,
  }) : super(
          name: name,
          materialIconName: materialIconName,
          functionGroup: functionGroup,
        ) {
    _initializePin();
  }

  factory MapItemType.fromJson(Map<String, dynamic> json) =>
      _$MapItemTypeFromJson(json);

  BitmapDescriptor? get pinIcon => _pinIcon;

  Future<void> _initializePin() async {
    String fullPinIconPath = PlatformTools.getIconsDir() + pinIconPath!;
    _pinIcon = await _loadPinIcon(fullPinIconPath);
  }

  Future<BitmapDescriptor> _loadPinIcon(String pinIconPath) async =>
      await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(size: Size(30, 45)),
        pinIconPath,
      );
}
