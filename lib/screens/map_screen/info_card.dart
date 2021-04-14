import 'package:flutter/material.dart';
import 'package:kampus_sggw/models/building.dart';
import 'package:kampus_sggw/models/category.dart';
import 'package:kampus_sggw/models/service.dart';
import 'package:kampus_sggw/screens/map_screen/filter_button.dart';
import 'package:kampus_sggw/screens/map_screen/simple_dialog_item.dart';

class InfoCardDialog extends StatelessWidget {
  String header;
  ListView description;
  ServiceButtonsRow servicesRow;

  final headerStyle = TextStyle(fontWeight: FontWeight.w500, fontSize: 26);

  InfoCardDialog({this.header, this.description});
  InfoCardDialog.fromBuilding(Building building) {
    this.header = building.name;
    this.description = ListView.builder(
      itemCount: data.length,
      itemBuilder: (BuildContext context, int index) => EntryItem(
        data[index],
      ),
    );
    this.servicesRow = ServiceButtonsRow.fromServices(building.services);
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text(header, style: headerStyle),
      children: [
        ClipRect(child: Image.asset("assets/images/map_objects/wzim.jpg")),
        Container(child: description, height: 160.0, width: 200.0)
      ]
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
                color: service.icon.color, icon: service.icon.icon))
            .toList());
  }
}

class Entry {
  final String title;
  final List<Entry> children;
  Entry(this.title, [this.children = const <Entry>[]]);
}

final List<Entry> data = <Entry>[
  Entry('Wydziały', <Entry>[
    Entry('Section A0', <Entry>[
      Entry('Item A0.1'),
      Entry('Item A0.2'),
      Entry('Item A0.3'),
    ]),
    Entry('Section A1'),
    Entry('Section A2', <Entry>[
      Entry('Item A2.1'),
      Entry('Item A2.2'),
      Entry('Item A2.3'),
    ])
  ]),
  Entry('Inne atrakcje', <Entry>[
    Entry('Section B0', <Entry>[
      Entry('Item B0.1'),
      Entry('Item B0.2'),
      Entry('Item B0.3'),
    ]),
    Entry('Section B1'),
    Entry('Section B2', <Entry>[
      Entry('Item B2.1'),
      Entry('Item B2.2'),
      Entry('Item B2.3'),
    ])
  ])
];

//Widget for Category row
class EntryItem extends StatelessWidget {
  final Entry entry;
  EntryItem(this.entry);

  @override
  Widget build(BuildContext context) {
    return _buildTiles(entry);
  }

  Widget _buildTiles(Entry root) {
    if (root.children.isEmpty) {
      return ListTile(title: Text(root.title));
    }
    return ExpansionTile(
      key: PageStorageKey<Entry>(root),
      title: Text(root.title),
      children: root.children.map<Widget>(_buildTiles).toList(),
    );
  }
}
