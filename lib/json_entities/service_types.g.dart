// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service_types.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ServiceTypes _$ServiceTypesFromJson(Map<String, dynamic> json) => ServiceTypes(
      serviceTypes: (json['serviceTypes'] as List<dynamic>?)
              ?.map((e) => ServiceType.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$ServiceTypesToJson(ServiceTypes instance) =>
    <String, dynamic>{
      'serviceTypes': instance.serviceTypes,
    };
