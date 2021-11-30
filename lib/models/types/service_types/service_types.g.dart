// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service_types.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ServiceTypes _$ServiceTypesFromJson(Map<String, dynamic> json) {
  return ServiceTypes(
    typesFromJson: (json['typesFromJson'] as List?)
        ?.map((e) =>
            e == null ? null : ServiceType.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}
