import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:kampus_sggw/logic/platform_tools.dart';
import 'package:kampus_sggw/models/map_object_application.dart';
import 'package:kampus_sggw/models/types/type_from_json.dart';
part 'map_item_type.g.dart';

@JsonSerializable()
class MapItemType extends TypeFromJSON {
  String pinIconPath;
  @JsonKey(ignore: true)
  BitmapDescriptor pinIcon;

  MapItemType({
    String name,
    this.pinIconPath,
    int materialIconID,
    String materialIconName,
    MapObjectApplication objectApplication,
  }) : super(
          name: name,
          materialIconID: materialIconID,
          materialIconName: materialIconName,
          objectApplication: objectApplication,
        ) {
    _initializePin();
  }

  factory MapItemType.fromJson(Map<String, dynamic> json) =>
      _$MapItemTypeFromJson(json);

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

  //void _setIconData() => iconData = iconMap[materialIconName];
}
