import 'package:flutter/material.dart';

enum ServiceType {
  xero,
  canteen,
  deanery,
  vendingMachine,
  lectureHall,
}

class Service {
  String name;
  Icon icon;
  ServiceType type;
  String description;
  Service({name, type, description}) {
    this.name = name;
    this.type = type;
    this.description = description;
    this.icon = _createIconForType(type);
  }

  Icon _createIconForType(ServiceType type) {
    switch (type) {
      case ServiceType.canteen:
        return Icon(Icons.restaurant, color: Colors.yellow[700]);
      case ServiceType.xero:
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
