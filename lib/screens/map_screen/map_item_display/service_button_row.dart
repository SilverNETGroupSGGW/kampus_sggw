import 'package:flutter/material.dart';
import 'package:kampus_sggw/models/service.dart';
import 'package:kampus_sggw/screens/map_screen/filter_button.dart';
import 'service_card.dart';

class ServiceButtonsRow extends StatefulWidget {
  final List<Service>? services;

  ServiceButtonsRow(this.services);

  @override
  _ServiceButtonsRowState createState() => _ServiceButtonsRowState();
}

class _ServiceButtonsRowState extends State<ServiceButtonsRow> {
  static Service? _selectedService;

  showServiceCard(Service service) {
    _selectedService = service;
    Navigator.of(context).restorablePush(_dialogBuilder);
  }

  static Route<void> _dialogBuilder(BuildContext context, Object? arguments) {
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
      children: widget.services!
          .map((Service service) => _createServiceButton(service))
          .toList(),
    );
  }

  FilterButton _createServiceButton(Service service) {
    return FilterButton(
      color: service.iconColor,
      iconData: service.iconData,
      onTapFunction: () => showServiceCard(service),
    );
  }
}
