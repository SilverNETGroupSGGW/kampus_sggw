import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:kampus_sggw/logic/platform_tools.dart';
import 'package:kampus_sggw/models/map_object_application.dart';
part 'map_item_type.g.dart';

@JsonSerializable()
class MapItemType {
  String name;
  String pinIconPath;
  int materialIconID;
  MapObjectApplication objectApplication;
  @JsonKey(ignore: true)
  BitmapDescriptor pinIcon;
  @JsonKey(ignore: true)
  Icon materialIcon;

  MapItemType(
    this.name,
    this.pinIconPath,
    this.materialIconID,
    this.objectApplication,
  ) {
    _initializeTypeAssets();
  }

  factory MapItemType.fromJson(Map<String, dynamic> json) =>
      _$MapItemTypeFromJson(json);

  void _initializeTypeAssets() {
    _initializePin();
    _initializeIcon();
  }

  void _initializeIcon() {
    materialIcon = Icon(IconData(materialIconID, fontFamily: 'MaterialIcons'));
  }

  Future<void> _initializePin() async {
    PlatformTools platformTools = PlatformTools();
    String fullPinIconPath = platformTools.getIconsDir() + pinIconPath;
    pinIcon = await _loadPinIcon(fullPinIconPath);
  }

  Future<BitmapDescriptor> _loadPinIcon(String pinIconPath) async =>
      await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(
          size: Size(30, 45),
        ),
        pinIconPath,
      );
}
