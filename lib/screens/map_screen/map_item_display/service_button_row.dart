import 'package:flutter/material.dart';
import 'package:kampus_sggw/logic/icon_map.dart';
import 'package:kampus_sggw/models/service.dart';
import 'package:kampus_sggw/screens/map_screen/filter_button.dart';
import 'service_card.dart';

class ServiceButtonsRow extends StatefulWidget {
  final List<Service> services;

  ServiceButtonsRow(this.services);

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
          .map((Service service) => _createServiceButton(service))
          .toList(),
    );
  }

  FilterButton _createServiceButton(Service service) {
    // const Icon icon = const Icon(IconData(codePoint));
    //const Icon icon = const Icon()
    //const int iconID = service.getIconID();
    //const IconData iconData =
    //const IconData(iconID, fontFamily: 'MaterialIcons');
    return FilterButton(
      color: Color(service.serviceType.colorInInt),
      iconData: iconMap[service.serviceType.materialIconName],
      onTapFunction: () => showServiceCard(service),
    );
  }
}
