// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'visit_history.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VisitHistory _$VisitHistoryFromJson(Map<String, dynamic> json) => VisitHistory(
      buffer: json['buffer'] as int? ?? 6,
      itemsIds:
          (json['itemsIds'] as List<dynamic>?)?.map((e) => e as int).toList() ??
              [],
    );

Map<String, dynamic> _$VisitHistoryToJson(VisitHistory instance) =>
    <String, dynamic>{
      'buffer': instance.buffer,
      'itemsIds': instance.itemsIds,
    };
