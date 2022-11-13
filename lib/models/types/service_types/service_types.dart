import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:kampus_sggw/models/types/service_types/service_type.dart';
import 'package:kampus_sggw/models/types/types_from_json.dart';

part 'service_types.g.dart';

@JsonSerializable()
class ServiceTypes extends TypesFromJson {
  ServiceTypes({List<ServiceType>? typesFromJson})
      : super(
          typesFromJson: typesFromJson,
        );

  static Future<ServiceTypes> loadFromJson() async {
    Map<String, dynamic> serviceTypesMap = jsonDecode(await _getJsonSting());
    return ServiceTypes.fromJson(serviceTypesMap);
  }

  factory ServiceTypes.fromJson(Map<String, dynamic> json) =>
      _$ServiceTypesFromJson(json);

  static Future<String> _getJsonSting() {
    return rootBundle.loadString('assets/json/service_types.json');
  }
}
