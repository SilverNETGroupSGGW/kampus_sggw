// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'map_items.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MapItems _$MapItemsFromJson(Map<String, dynamic> json) => MapItems(
      (json['mapItems'] as List<dynamic>?)
          ?.map((e) => MapItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MapItemsToJson(MapItems instance) => <String, dynamic>{
      'mapItems': instance.mapItems,
    };
