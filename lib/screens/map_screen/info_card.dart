import 'package:flutter/material.dart';
import 'package:kampus_sggw/models/building.dart';
import 'package:kampus_sggw/models/category.dart';
import 'package:kampus_sggw/models/service.dart';
import 'package:kampus_sggw/screens/map_screen/filter_button.dart';
import 'package:kampus_sggw/screens/map_screen/simple_dialog_item.dart';

class InfoCardDialog extends StatelessWidget {
  String header;
  CategoriesStatefulList description;
  ServiceButtonsRow servicesRow;

  final headerStyle = TextStyle(fontWeight: FontWeight.w500, fontSize: 26);

  InfoCardDialog({this.header, this.description});
  InfoCardDialog.fromBuilding(Building building) {
    this.header = building.name;
    this.description = CategoriesStatefulList(categories: building.categories);
    this.servicesRow = ServiceButtonsRow.fromServices(building.services);
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text(header, style: headerStyle),
      children: [
        ClipRect(child: Image.asset("assets/images/map_objects/wzim.jpg"))
      ]
        ..add(description)
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

class CategoriesStatefulList extends StatefulWidget {
  final List<Category> categories;

  const CategoriesStatefulList({Key key, this.categories}) : super(key: key);
  @override
  _CategoriesStatefulListState createState() => _CategoriesStatefulListState();
}

class _CategoriesStatefulListState extends State<CategoriesStatefulList> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: _buildPanel(),
      ),
      padding: EdgeInsets.all(20.0),
    );
  }

  Widget _buildPanel() {
    List<CategoryStatefulListItem> _data = widget.categories
        .map((Category category) => CategoryStatefulListItem(
            headerValue: category.name, expandedValue: "COKOLWIEK"))
        .toList();
    return ExpansionPanelList(
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          _data[index].isExpanded = !isExpanded;
        });
      },
      children: _data.map<ExpansionPanel>((CategoryStatefulListItem item) {
        return ExpansionPanel(
          headerBuilder: (BuildContext context, bool isExpanded) {
            return ListTile(
              title: Text(item.headerValue),
            );
          },
          body: ListTile(
              title: Text(item.expandedValue),
              subtitle:
                  const Text('To delete this panel, tap the trash can icon'),
              trailing: const Icon(Icons.delete),
              onTap: () {
                setState(() {
                  _data.removeWhere((CategoryStatefulListItem currentItem) =>
                      item == currentItem);
                });
              }),
          isExpanded: item.isExpanded,
        );
      }).toList(),
    );
  }
}

class CategoryStatefulListItem {
  CategoryStatefulListItem({
    this.expandedValue,
    this.headerValue,
    this.isExpanded = false,
  });

  String expandedValue;
  String headerValue;
  bool isExpanded;
}

List<CategoryStatefulListItem> createCategoryListItems(
    List<Category> categories) {
  return categories
      .map((Category category) => CategoryStatefulListItem(
          headerValue: category.name, expandedValue: category.description))
      .toList();
}
