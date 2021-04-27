import 'package:flutter/material.dart';
import 'package:kampus_sggw/screens/map_screen/filter_button.dart';

class FilterButtonsRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: EdgeInsets.only(
          bottom: 15,
          top: 1,
          right: 10,
        ),
        child: Row(
          children: <Widget>[
            FilterButton(
              color: Colors.yellow[700],
              icon: Icons.restaurant,
              onTapFunction: () => {},
            ),
            FilterButton(
              color: Colors.blue,
              icon: Icons.bus_alert,
              onTapFunction: () => {},
            ),
            FilterButton(
              color: Colors.orange,
              icon: Icons.local_parking,
              onTapFunction: () => {},
            ),
            FilterButton(
              color: Colors.green,
              icon: Icons.park,
              onTapFunction: () => {},
            ),
            FilterButton(
              color: Colors.red[300],
              icon: Icons.local_grocery_store,
              onTapFunction: () => {},
            ),
            FilterButton(
              color: Colors.indigo,
              icon: Icons.print_rounded,
              onTapFunction: () => {},
            ),
          ],
        ),
      ),
    );
  }
}
