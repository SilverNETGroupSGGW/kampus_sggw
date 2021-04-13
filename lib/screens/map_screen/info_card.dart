import 'package:flutter/material.dart';
import 'package:kampus_sggw/models/building.dart';
import 'package:kampus_sggw/models/category.dart';
import 'package:kampus_sggw/models/service.dart';
import 'package:kampus_sggw/screens/map_screen/filter_button.dart';
import 'package:kampus_sggw/screens/map_screen/simple_dialog_item.dart';

class InfoCardDialog extends StatelessWidget {
  String header;
  List<SimpleDialogItem> description;
  ServiceButtonsRow servicesRow;

  final headerStyle = TextStyle(fontWeight: FontWeight.bold, fontSize: 26);

  InfoCardDialog({this.header, this.description});
  InfoCardDialog.fromBuilding(Building building) {
    this.header = building.name;
    this.description = building.categories
        .map((Category category) => SimpleDialogItem(
              text: category.name,
              onPressed: () {},
            ))
        .toList();
    this.servicesRow = ServiceButtonsRow.fromServices(building.services);
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text(header, style: headerStyle),
      children: [
        ClipRect(child: Image.asset("assets/images/map_objects/wzim.jpg"))
      ]
        ..addAll(description)
        ..add(Divider(
          color: Colors.grey[800],
          thickness: 1.5,
          indent: 12.0,
          endIndent: 12.0,
        ))
        ..add(SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Padding(
              padding: EdgeInsets.only(
                bottom: 15,
                left: 5,
                top: 5,
              ),
              child: servicesRow),
        )),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
    );
  }
}

class ServiceButtonsRow extends StatelessWidget {
  List<Service> services = [];

  ServiceButtonsRow(this.services);
  ServiceButtonsRow.fromServices(List<Service> services) {
    if (services != null) this.services = services;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
        children: services
            .map((Service service) => FilterButton(
                color: _getIconColor(service.type),
                icon: service.icon.icon))
            .toList());
  }

  Color _getIconColor(ServiceType type) {
    switch (type) {
      case ServiceType.canteen:
        return Colors.yellow[700];
      case ServiceType.xero:
        return Colors.indigo;
      case ServiceType.deanery:
        return Colors.red[400];
      case ServiceType.vendingMachine:
        return Colors.pink[400];
      case ServiceType.lectureHall:
        return Colors.lightBlue[600];
    }
  }
}
