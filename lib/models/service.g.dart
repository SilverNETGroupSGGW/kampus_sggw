// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Service _$ServiceFromJson(Map<String, dynamic> json) => Service(
      json['name'] as String?,
      json['type'] as String?,
      json['description'] as String?,
      json['url'] as String?,
      json['photoPath'] as String?,
    );

Map<String, dynamic> _$ServiceToJson(Service instance) => <String, dynamic>{
      'name': instance.name,
      'type': instance.type,
      'description': instance.description,
      'url': instance.url,
      'photoPath': instance.photoPath,
    };
