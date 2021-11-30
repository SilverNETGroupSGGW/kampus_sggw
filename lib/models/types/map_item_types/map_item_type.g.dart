// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'map_item_type.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MapItemType _$MapItemTypeFromJson(Map<String, dynamic> json) => MapItemType(
      name: json['name'] as String?,
      materialIconName: json['materialIconName'] as String?,
      functionGroup: $enumDecodeNullable(
          _$ObjectFunctionGroupEnumMap, json['functionGroup']),
      pinIconPath: json['pinIconPath'] as String?,
    );

Map<String, dynamic> _$MapItemTypeToJson(MapItemType instance) =>
    <String, dynamic>{
      'name': instance.name,
      'materialIconName': instance.materialIconName,
      'functionGroup': _$ObjectFunctionGroupEnumMap[instance.functionGroup],
      'pinIconPath': instance.pinIconPath,
    };

const _$ObjectFunctionGroupEnumMap = {
  ObjectFunctionGroup.food: 'food',
  ObjectFunctionGroup.transport: 'transport',
  ObjectFunctionGroup.parking: 'parking',
  ObjectFunctionGroup.park: 'park',
  ObjectFunctionGroup.store: 'store',
  ObjectFunctionGroup.study: 'study',
  ObjectFunctionGroup.copier: 'copier',
};
