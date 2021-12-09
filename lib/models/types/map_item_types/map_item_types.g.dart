// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'map_item_types.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MapItemTypes _$MapItemTypesFromJson(Map<String, dynamic> json) => MapItemTypes(
      typesFromJson: (json['typesFromJson'] as List<dynamic>?)
          ?.map((e) => MapItemType.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MapItemTypesToJson(MapItemTypes instance) =>
    <String, dynamic>{
      'typesFromJson': instance.typesFromJson,
    };
