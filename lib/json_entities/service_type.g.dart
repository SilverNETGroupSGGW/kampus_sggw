// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service_type.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ServiceType _$ServiceTypeFromJson(Map<String, dynamic> json) => ServiceType(
      name: json['name'] as String,
      materialIconName: json['materialIconName'] as String,
      color: json['color'] as String? ?? '0xFF9E9E9E',
    );

Map<String, dynamic> _$ServiceTypeToJson(ServiceType instance) =>
    <String, dynamic>{
      'name': instance.name,
      'materialIconName': instance.materialIconName,
      'color': instance.color,
    };
