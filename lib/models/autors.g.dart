// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'autors.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Autors _$AutorsFromJson(Map<String, dynamic> json) => Autors(
      json['name'] as String?,
      json['lang'] as String?,
      (json['autorsList'] as List<dynamic>?)
          ?.map((e) => Autor.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AutorsToJson(Autors instance) => <String, dynamic>{
      'name': instance.name,
      'lang': instance.lang,
      'autorsList': instance.autorsList,
    };
