// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'map_item_types.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MapItemTypes _$MapItemTypesFromJson(Map<String, dynamic> json) {
  return MapItemTypes(
    typesFromJson: (json['typesFromJson'] as List)
        ?.map((e) =>
            e == null ? null : MapItemType.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}
