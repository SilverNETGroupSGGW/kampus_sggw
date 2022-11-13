import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:kampus_sggw/logic/object_function_group.dart';
import 'package:kampus_sggw/models/types/service_types/service_type.dart';
import 'package:kampus_sggw/models/types/service_types/service_types.dart';
part 'service.g.dart';

@JsonSerializable()
class Service {
  String? name;
  String? type;
  String? description;
  String? url;
  String? photoPath;
  ServiceType? _serviceType;

  Service(
    this.name,
    this.type,
    this.description,
    this.url,
    this.photoPath,
  );

  factory Service.fromJson(Map<String, dynamic> json) =>
      _$ServiceFromJson(json);

  void setType(ServiceTypes serviceTypes) =>
      _serviceType = serviceTypes.types[type] as ServiceType?;

  Color get iconColor => Color(_serviceType!.colorInHex!);
  IconData? get iconData => _serviceType!.iconData;
  ObjectFunctionGroup? get functionGroup => _serviceType!.functionGroup;
  Set<String?> get wordsToCompareWithSearchQuery => {name, description};
}
