import 'package:flutter/material.dart';
import 'package:kampus_sggw/logic/controllers/map_controller.dart';
import 'package:kampus_sggw/logic/controllers/search_button_controller.dart';
import 'package:provider/provider.dart';

class MapButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        FloatingActionButton(
          child: const Icon(Icons.map),
          backgroundColor: Colors.lightGreen,
          onPressed: () =>
              Provider.of<MapController>(context, listen: false).recenter(),
          heroTag: "btn1",
        ),
        Padding(
          padding: EdgeInsets.all(5),
        ),
        Provider.of<SearchButtonController>(context, listen: true).button!,
      ],
    );
  }
}
