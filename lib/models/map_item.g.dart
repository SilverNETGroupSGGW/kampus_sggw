// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'map_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MapItem _$MapItemFromJson(Map<String, dynamic> json) => MapItem(
      id: json['id'] as int?,
      geoLocation: json['geoLocation'] == null
          ? null
          : Location.fromJson(json['geoLocation'] as Map<String, dynamic>),
      name: json['name'] as String?,
      description: json['description'] as String?,
      url: json['url'] as String?,
      type: json['type'] as String?,
      photoPath: json['photoPath'] as String?,
      minScale: (json['minScale'] as num?)?.toDouble(),
      lastModified: json['lastModified'] == null
          ? null
          : DateTime.parse(json['lastModified'] as String),
      gallery: (json['gallery'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      services: (json['services'] as List<dynamic>?)
              ?.map((e) => Service.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      categories: (json['categories'] as List<dynamic>?)
              ?.map((e) => Category.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$MapItemToJson(MapItem instance) => <String, dynamic>{
      'id': instance.id,
      'geoLocation': instance.geoLocation,
      'name': instance.name,
      'description': instance.description,
      'url': instance.url,
      'type': instance.type,
      'photoPath': instance.photoPath,
      'minScale': instance.minScale,
      'lastModified': instance.lastModified?.toIso8601String(),
      'gallery': instance.gallery,
      'services': instance.services,
      'categories': instance.categories,
    };
