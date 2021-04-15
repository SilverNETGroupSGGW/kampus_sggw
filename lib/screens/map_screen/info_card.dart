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
    final data = building.categories;
    this.description = ListView.builder(
      itemCount: data.length,
      itemBuilder: (BuildContext context, int index) => CategoryItem(
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
                color: service.icon.color, icon: service.icon.icon, onTapFunction: () => {},))
            .toList());
  }
}

//Widget for Category row
class CategoryItem extends StatelessWidget {
  final Category category;
  CategoryItem(this.category);

  @override
  Widget build(BuildContext context) {
    return _buildTiles(category);
  }

  Widget _buildTiles(Category root) {
    if (root.subCategories == null || root.subCategories.isEmpty) {
      return ListTile(title: Text(root.name));
    }
    return ExpansionTile(
      key: PageStorageKey<Category>(root),
      title: Text(root.name),
      children: root.subCategories.map<Widget>(_buildTiles).toList(),
    );
  }
}
