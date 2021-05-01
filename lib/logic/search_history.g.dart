// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_history.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchHistory _$SearchHistoryFromJson(Map<String, dynamic> json) {
  return SearchHistory(
    json['buffer'] as int ?? 6,
    (json['searchHistory'] as List)?.map((e) => e as String)?.toList() ?? [],
  );
}

Map<String, dynamic> _$SearchHistoryToJson(SearchHistory instance) =>
    <String, dynamic>{
      'buffer': instance.buffer,
      'searchHistory': instance.searchHistory,
    };
