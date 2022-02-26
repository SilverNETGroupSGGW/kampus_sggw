// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'map_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MapItem _$MapItemFromJson(Map<String, dynamic> json) => MapItem(
      id: json['id'] as String,
      geoLocation:
          GeoLocation.fromJson(json['geoLocation'] as Map<String, dynamic>),
      name: json['name'] as String,
      description: json['description'] as String?,
      type: json['type'] as String,
      buildingService: (json['buildingService'] as List<dynamic>?)
              ?.map((e) => BuildingService.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      faculties: (json['faculties'] as List<dynamic>?)
              ?.map((e) => Faculty.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      institutes: (json['institutes'] as List<dynamic>?)
              ?.map((e) => Institute.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      offices: (json['offices'] as List<dynamic>?)
              ?.map((e) => Office.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      functionGroup: (json['functionGroup'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
    );

Map<String, dynamic> _$MapItemToJson(MapItem instance) => <String, dynamic>{
      'id': instance.id,
      'geoLocation': instance.geoLocation,
      'name': instance.name,
      'description': instance.description,
      'type': instance.type,
      'buildingService': instance.buildingService,
      'faculties': instance.faculties,
      'institutes': instance.institutes,
      'offices': instance.offices,
      'functionGroup': instance.functionGroup,
    };
