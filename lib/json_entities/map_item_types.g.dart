// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'map_item_types.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MapItemTypes _$MapItemTypesFromJson(Map<String, dynamic> json) => MapItemTypes(
      mapItemTypes: (json['mapItemTypes'] as List<dynamic>?)
              ?.map((e) => MapItemType.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$MapItemTypesToJson(MapItemTypes instance) =>
    <String, dynamic>{
      'mapItemTypes': instance.mapItemTypes,
    };
