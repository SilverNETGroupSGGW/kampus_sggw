// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'map_items.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MapItems _$MapItemsFromJson(Map<String, dynamic> json) {
  return MapItems(
    (json['mapItems'] as List?)
        ?.map((e) =>
            e == null ? null : MapItem.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}
