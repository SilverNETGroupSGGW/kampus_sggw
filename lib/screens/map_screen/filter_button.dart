import 'package:flutter/material.dart';

class FilterButton extends StatelessWidget {
  final color;
  final icon;
  final onTapFunction;

  const FilterButton({
    Key key,
    @required this.color,
    @required this.icon,
    @required this.onTapFunction,
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
          onPressed: () => onTapFunction(),
        ),
      ),
    );
  }
}
