import 'package:flutter/material.dart';

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

class FilterButton extends StatelessWidget {
  final color;
  final icon;

  const FilterButton({
    Key key,
    @required this.color,
    @required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 10,
      ),
      child: Container(
        height: 60.0,
        width: 60.0,
        child: FloatingActionButton(
          child: Icon(
            icon,
            size: 35.0,
          ),
          backgroundColor: color,
          onPressed: () {},
        ),
      ),
    );
  }
}
