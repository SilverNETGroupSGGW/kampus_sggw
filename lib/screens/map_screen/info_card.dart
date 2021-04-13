import 'package:flutter/material.dart';
import 'package:kampus_sggw/models/building.dart';
import 'package:kampus_sggw/models/category.dart';
import 'package:kampus_sggw/screens/map_screen/simple_dialog_item.dart';

class InfoCardDialog extends StatelessWidget {
  String header;
  List<SimpleDialogItem> description;

  final headerStyle = TextStyle(fontWeight: FontWeight.bold, fontSize: 30);

  InfoCardDialog({this.header, this.description});
  InfoCardDialog.fromBuilding(Building building) {
    this.header = building.name;
    // this.description = Column(
    //   mainAxisSize: MainAxisSize.min,
    //   children: [
    //     for (var category in building.categories) {
    //       DropdownButton<String>(
    //         value: category.name,
    //         items: [],
    //       )
    //     }
    //   ],
    // );
    this.description = building.categories
        .map((Category category) => SimpleDialogItem(
              text: category.name,
              onPressed: () {},
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text(header, style: headerStyle),
      children: description,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
    );
  }
}
