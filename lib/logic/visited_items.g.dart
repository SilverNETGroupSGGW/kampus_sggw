// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'visited_items.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VisitedItems _$VisitedItemsFromJson(Map<String, dynamic> json) {
  return VisitedItems(
    json['buffer'] as int ?? 6,
    (json['visitedItemsIds'] as List)?.map((e) => e as int)?.toList() ?? [],
  );
}

Map<String, dynamic> _$VisitedItemsToJson(VisitedItems instance) =>
    <String, dynamic>{
      'buffer': instance.buffer,
      'visitedItemsIds': instance.visitedItemsIds,
    };
