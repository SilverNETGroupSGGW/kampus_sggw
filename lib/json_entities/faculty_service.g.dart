// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'faculty_service.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FacultyService _$FacultyServiceFromJson(Map<String, dynamic> json) =>
    FacultyService(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      type: json['type'] as String,
    );

Map<String, dynamic> _$FacultyServiceToJson(FacultyService instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'type': instance.type,
    };
