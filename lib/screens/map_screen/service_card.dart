import 'package:flutter/material.dart';
import 'package:kampus_sggw/models/service.dart';

class ServiceCard extends StatelessWidget {
  final Service service;
  ServiceCard({this.service});

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(title: Text("HELLO from " + service.name),);
  }
}
