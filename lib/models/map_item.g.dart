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
    json['type'] as String,
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
