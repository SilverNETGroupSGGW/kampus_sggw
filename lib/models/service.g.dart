// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Service _$ServiceFromJson(Map<String, dynamic> json) {
  return Service(
    json['name'] as String,
    _$enumDecodeNullable(_$ServiceTypeEnumMap, json['type']),
    json['description'] as String,
    json['url'] as String,
    json['photoPath'] as String,
  );
}

Map<String, dynamic> _$ServiceToJson(Service instance) => <String, dynamic>{
      'name': instance.name,
      'type': _$ServiceTypeEnumMap[instance.type],
      'description': instance.description,
      'url': instance.url,
      'photoPath': instance.photoPath,
    };

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

const _$ServiceTypeEnumMap = {
  ServiceType.copier: 'copier',
  ServiceType.canteen: 'canteen',
  ServiceType.deanery: 'deanery',
  ServiceType.vendingMachine: 'vendingMachine',
  ServiceType.lectureHall: 'lectureHall',
  ServiceType.library: 'library',
  ServiceType.medicine: 'medicine',
};
