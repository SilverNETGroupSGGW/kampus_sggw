// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_history.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserHistory _$UserHistoryFromJson(Map<String, dynamic> json) {
  return UserHistory(
    buffer: json['buffer'] as int ?? 6,
    itemsIds: (json['itemsIds'] as List)?.map((e) => e as int)?.toList() ?? [],
  );
}

Map<String, dynamic> _$UserHistoryToJson(UserHistory instance) =>
    <String, dynamic>{
      'buffer': instance.buffer,
      'itemsIds': instance.itemsIds,
    };
