// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'institute.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Institute _$InstituteFromJson(Map<String, dynamic> json) => Institute(
      id: json['id'] as String,
      name: json['name'] as String,
      url: json['url'] as String?,
      description: json['description'] as String?,
      departments: (json['departments'] as List<dynamic>?)
              ?.map((e) => Department.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$InstituteToJson(Institute instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'url': instance.url,
      'description': instance.description,
      'departments': instance.departments,
    };
