// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'faculty.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Faculty _$FacultyFromJson(Map<String, dynamic> json) => Faculty(
      id: json['id'] as String,
      name: json['name'] as String,
      url: json['url'] as String?,
      description: json['description'] as String?,
      facultyServices: (json['facultyServices'] as List<dynamic>?)
              ?.map((e) => FacultyService.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$FacultyToJson(Faculty instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'url': instance.url,
      'description': instance.description,
      'facultyServices': instance.facultyServices,
    };
