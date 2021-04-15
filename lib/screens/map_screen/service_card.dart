import 'package:flutter/material.dart';
import 'package:kampus_sggw/models/service.dart';

class ServiceCard extends StatelessWidget {
  final Service service;
  ServiceCard({this.service});

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text(service.name),
      children: [
        Padding(
          padding: const EdgeInsets.only(
            bottom: 15,
            left: 22,
            right: 22,
            top: 5,
          ),
          child: Text(service.description),
        )
      ],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
    );
  }
}
