// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'building_service.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BuildingService _$BuildingServiceFromJson(Map<String, dynamic> json) =>
    BuildingService(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      type: json['type'] as String,
    );

Map<String, dynamic> _$BuildingServiceToJson(BuildingService instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'type': instance.type,
    };
