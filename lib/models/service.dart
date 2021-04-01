import 'package:flutter/material.dart';

enum ServiceType { xero, canteen, deanery}

class Service {
  String name;
  Icon icon;
  ServiceType type;
  String description;
  Service({
    this.name,
    this.icon,
    this.type,
    this.description,
  });
}
