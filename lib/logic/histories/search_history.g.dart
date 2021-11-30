// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_history.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchHistory _$SearchHistoryFromJson(Map<String, dynamic> json) =>
    SearchHistory(
      buffer: json['buffer'] as int? ?? 6,
      itemsIds:
          (json['itemsIds'] as List<dynamic>?)?.map((e) => e as int).toList() ??
              [],
    );

Map<String, dynamic> _$SearchHistoryToJson(SearchHistory instance) =>
    <String, dynamic>{
      'buffer': instance.buffer,
      'itemsIds': instance.itemsIds,
    };
