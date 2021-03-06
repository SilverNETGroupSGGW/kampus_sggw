// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'map_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MapItem _$MapItemFromJson(Map<String, dynamic> json) {
  return MapItem(
    json['id'] as int,
    json['geoLocation'] == null
        ? null
        : Location.fromJson(json['geoLocation'] as Map<String, dynamic>),
    json['name'] as String,
    json['description'] as String,
    json['url'] as String,
    _$enumDecodeNullable(_$MapItemTypeEnumMap, json['type']),
    json['photoPath'] as String,
    (json['minScale'] as num)?.toDouble(),
    json['lastModified'] == null
        ? null
        : DateTime.parse(json['lastModified'] as String),
    (json['gallery'] as List)?.map((e) => e as String)?.toList(),
    (json['services'] as List)
        ?.map((e) =>
            e == null ? null : Service.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    (json['categories'] as List)
        ?.map((e) =>
            e == null ? null : Category.fromJson(e as Map<String, dynamic>))
        ?.toList(),
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

const _$MapItemTypeEnumMap = {
  MapItemType.facultyBuilding: 'facultyBuilding',
  MapItemType.administrationBuilding: 'administrationBuilding',
  MapItemType.sportsFacility: 'sportsFacility',
  MapItemType.store: 'store',
  MapItemType.food: 'food',
  MapItemType.library: 'library',
  MapItemType.parking: 'parking',
  MapItemType.transport: 'transport',
  MapItemType.finance: 'finance',
  MapItemType.dormitories: 'dormitories',
  MapItemType.kindergarten: 'kindergarten',
  MapItemType.monument: 'monument',
  MapItemType.medicine: 'medicine',
};
