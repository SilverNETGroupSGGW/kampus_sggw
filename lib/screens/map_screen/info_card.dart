import 'package:flutter/material.dart';
import '../../models/building.dart';

class InfoCardDialog extends StatelessWidget {
  String header;
  String description;

  final headerStyle = TextStyle(fontWeight: FontWeight.bold, fontSize: 30);

  InfoCardDialog({this.header, this.description});
  InfoCardDialog.fromBuilding(Building building) {
    this.header = building.name;
    this.description = '';
    for (var category in building.categories[0].subCategories) {
      this.description += category.name;
      this.description += "\n";
    }
    //this.description = building.categories..join("\n");
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(header, style: headerStyle),
      content: Text(description),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text("Ok"),
        ),
      ],
    );
  }
}
