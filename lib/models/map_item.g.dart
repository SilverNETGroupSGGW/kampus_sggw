// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'map_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MapItem _$MapItemFromJson(Map<String, dynamic> json) {
  return MapItem(
    id: json['id'] as int,
    geoLocation: json['geoLocation'] == null
        ? null
        : Location.fromJson(json['geoLocation'] as Map<String, dynamic>),
    name: json['name'] as String,
    description: json['description'] as String,
    url: json['url'] as String,
    type: json['type'] as String,
    photoPath: json['photoPath'] as String,
    minScale: (json['minScale'] as num)?.toDouble(),
    lastModified: json['lastModified'] == null
        ? null
        : DateTime.parse(json['lastModified'] as String),
    gallery: (json['gallery'] as List)?.map((e) => e as String)?.toList(),
    services: (json['services'] as List)
        ?.map((e) =>
            e == null ? null : Service.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    categories: (json['categories'] as List)
        ?.map((e) =>
            e == null ? null : Category.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}
