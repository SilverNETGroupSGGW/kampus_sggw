import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
part 'service.g.dart';

enum ServiceType {
  copier,
  canteen,
  deanery,
  vendingMachine,
  lectureHall,
  library,
  medicine,
}

@JsonSerializable()
class Service {
  String name;
  ServiceType type;
  String description;
  String url;
  String photoPath;
  @JsonKey(ignore: true)
  Icon icon;

  Service(this.name, this.type, this.description, this.url, this.photoPath) {
    this.icon = _createIconForType(type);
  }
  factory Service.fromJson(Map<String, dynamic> json) =>
      _$ServiceFromJson(json);

  Icon _createIconForType(ServiceType type) {
    switch (type) {
      case ServiceType.canteen:
        return Icon(Icons.restaurant, color: Colors.yellow[700]);
      case ServiceType.copier:
        return Icon(Icons.print_rounded, color: Colors.indigo);
      case ServiceType.deanery:
        return Icon(Icons.event_seat, color: Colors.red[400]);
      case ServiceType.vendingMachine:
        return Icon(Icons.payment, color: Colors.pink[400]);
      case ServiceType.lectureHall:
        return Icon(Icons.account_balance, color: Colors.lightBlue[600]);
      default:
        return null;
    }
  }
}
