// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'authors.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Authors _$AuthorsFromJson(Map<String, dynamic> json) => Authors(
      json['name'] as String?,
      json['lang'] as String?,
      (json['authorsList'] as List<dynamic>?)
          ?.map((e) => Author.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AuthorsToJson(Authors instance) => <String, dynamic>{
      'name': instance.name,
      'lang': instance.lang,
      'authorsList': instance.authorsList,
    };
