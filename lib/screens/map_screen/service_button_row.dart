import 'package:flutter/material.dart';
import 'package:kampus_sggw/models/service.dart';
import 'package:kampus_sggw/screens/map_screen/service_card.dart';
import 'package:kampus_sggw/screens/map_screen/filter_button.dart';

class ServiceButtonsRow extends StatefulWidget {
  List<Service> services = [];

  ServiceButtonsRow(this.services);
  ServiceButtonsRow.fromServices(List<Service> services) {
    if (services != null) this.services = services;
  }

  @override
  _ServiceButtonsRowState createState() => _ServiceButtonsRowState();
}

class _ServiceButtonsRowState extends State<ServiceButtonsRow> {
  static Service _selectedService;

  showServiceCard(Service service) {
    _selectedService = service;
    Navigator.of(context).restorablePush(_dialogBuilder);
  }

  static Route<Object> _dialogBuilder(BuildContext context, Object arguments) {
    return DialogRoute<void>(
      context: context,
      builder: (BuildContext context) => ServiceCard(
        service: _selectedService,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: widget.services
          .map(
            (Service service) => FilterButton(
              color: service.icon.color,
              icon: service.icon.icon,
              onTapFunction: () => showServiceCard(service),
            ),
          )
          .toList(),
    );
  }
}
