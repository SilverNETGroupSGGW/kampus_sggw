// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'map_item_type.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MapItemType _$MapItemTypeFromJson(Map<String, dynamic> json) => MapItemType(
      name: json['name'] as String,
      materialIconName: json['materialIconName'] as String,
      pinIconPath: json['pinIconPath'] as String? ?? 'otherMarker.png',
    );

Map<String, dynamic> _$MapItemTypeToJson(MapItemType instance) =>
    <String, dynamic>{
      'name': instance.name,
      'materialIconName': instance.materialIconName,
      'pinIconPath': instance.pinIconPath,
    };
