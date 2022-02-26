import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:kampus_sggw/models/types/service_types/service_type.dart';
part 'service_types.g.dart';

@JsonSerializable()
class ServiceTypes {
  @JsonKey(defaultValue: <ServiceType>[])
  List<ServiceType> serviceTypes;

  ServiceTypes({
    required this.serviceTypes,
  });

  static Future<ServiceTypes> loadFromJson() async {
    Map<String, dynamic> mapItemTypesMap = jsonDecode(await _getJsonSting());
    return ServiceTypes.fromJson(mapItemTypesMap);
  }

  factory ServiceTypes.fromJson(Map<String, dynamic> json) =>
      _$ServiceTypesFromJson(json);

  static Future<String> _getJsonSting() {
    return rootBundle.loadString('assets/json/service_types.json');
  }
}
