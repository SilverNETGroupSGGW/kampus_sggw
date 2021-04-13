import 'package:flutter/material.dart';
import 'package:kampus_sggw/screens/map_screen/filter_button.dart';

class FilterButtonsRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        FilterButton(
          color: Colors.yellow[700],
          icon: Icons.restaurant,
        ),
        FilterButton(
          color: Colors.blue,
          icon: Icons.bus_alert,
        ),
        FilterButton(
          color: Colors.orange,
          icon: Icons.local_parking,
        ),
        FilterButton(
          color: Colors.green,
          icon: Icons.park,
        ),
        FilterButton(
          color: Colors.red[300],
          icon: Icons.local_grocery_store,
        ),
        Padding(
          padding: EdgeInsets.only(
            right: 10,
          ),
          child: FilterButton(
            color: Colors.indigo,
            icon: Icons.print_rounded,
          ),
        ),
      ],
    );
  }
}
