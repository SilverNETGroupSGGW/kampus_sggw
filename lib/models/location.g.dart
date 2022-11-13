// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Location _$LocationFromJson(Map<String, dynamic> json) => Location(
      (json['lat'] as num?)?.toDouble(),
      (json['lon'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$LocationToJson(Location instance) => <String, dynamic>{
      'lat': instance.lat,
      'lon': instance.lon,
    };
