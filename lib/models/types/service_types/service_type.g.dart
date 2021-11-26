// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service_type.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ServiceType _$ServiceTypeFromJson(Map<String, dynamic> json) {
  return ServiceType(
    name: json['name'] as String,
    materialIconName: json['materialIconName'] as String,
    objectApplication: _$enumDecodeNullable(
        _$MapObjectApplicationsEnumMap, json['functionGroup']),
    color: json['color'] as String ?? '0xFF9E9E9E',
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

const _$MapObjectApplicationsEnumMap = {
  MapObjectApplication.food: 'food',
  MapObjectApplication.transport: 'transport',
  MapObjectApplication.parking: 'parking',
  MapObjectApplication.park: 'park',
  MapObjectApplication.store: 'store',
  MapObjectApplication.study: 'study',
  MapObjectApplication.copier: 'copier',
};
