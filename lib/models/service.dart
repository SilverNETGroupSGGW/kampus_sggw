import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:kampus_sggw/models/types/service_types/service_type.dart';
import 'package:kampus_sggw/models/types/service_types/service_types.dart';
part 'service.g.dart';

@JsonSerializable()
class Service {
  String name;
  String type;
  String description;
  String url;
  String photoPath;
  @JsonKey(ignore: true)
  ServiceType serviceType;

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
      serviceType = serviceTypes.getTypeByName(type);

  //int getIconID() => serviceType.materialIconID;
  //IconData getIconsData() => serviceType.iconData;
  int getIconColor() => serviceType.colorInInt;
}
