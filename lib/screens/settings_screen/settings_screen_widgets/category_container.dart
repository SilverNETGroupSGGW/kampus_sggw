import 'package:flutter/material.dart';

class CategoryContainer extends StatelessWidget {
  final List<Widget> children;

  const CategoryContainer({Key? key, required this.children}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: 15.0,
        right: 15.0,
        top: 20.0,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).focusColor,
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      child: Column(
        children: children.toList(),
      ),
    );
  }
}
