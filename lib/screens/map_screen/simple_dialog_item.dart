import 'package:flutter/material.dart';

class SimpleDialogItem extends StatelessWidget {
  const SimpleDialogItem(
      {Key key, this.text, this.onPressed})
      : super(key: key);

  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SimpleDialogOption(
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsetsDirectional.only(start: 6.0),
            child: Text(text, style: TextStyle(fontSize: 16.0),),
          ),
        ],
      ),
    );
  }
}
