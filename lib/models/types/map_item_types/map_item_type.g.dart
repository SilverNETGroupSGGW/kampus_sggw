// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'map_item_type.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MapItemType _$MapItemTypeFromJson(Map<String, dynamic> json) {
  return MapItemType(
    name: json['name'] as String,
    pinIconPath: json['pinIconPath'] as String,
    materialIconName: json['materialIconName'] as String,
    functionGroup: _$enumDecodeNullable(
        _$ObjectFunctionGroupsEnumMap, json['functionGroup']),
  );
}

T _$enumDecode<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }

  final value = enumValues.entries
      .singleWhere((e) => e.value == source, orElse: () => null)
      ?.key;

  if (value == null && unknownValue == null) {
    throw ArgumentError('`$source` is not one of the supported values: '
        '${enumValues.values.join(', ')}');
  }
  return value ?? unknownValue;
}

T _$enumDecodeNullable<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source, unknownValue: unknownValue);
}

const _$ObjectFunctionGroupsEnumMap = {
  ObjectFunctionGroup.food: 'food',
  ObjectFunctionGroup.transport: 'transport',
  ObjectFunctionGroup.parking: 'parking',
  ObjectFunctionGroup.park: 'park',
  ObjectFunctionGroup.store: 'store',
  ObjectFunctionGroup.study: 'study',
  ObjectFunctionGroup.copier: 'copier',
};
