import 'package:flutter/material.dart';
import 'package:kampus_sggw/logic/keyboard_utils.dart';

class BottomDrawer {
  final BuildContext context;
  final List<Widget> children;

  const BottomDrawer({required this.context, required this.children});

  void showBottomDrawer() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(
              bottom: KeyboardUtils.keyboardHeight(context),
            ),
            child: Container(
              height: _heightOfDrawer(context),
              child: SingleChildScrollView(
                child: Column(
                  children: children.toList(),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  double _heightOfDrawer(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var keyboardHeight = KeyboardUtils.keyboardHeight(context);

    if (KeyboardUtils.isOpen(context)) {
      return (screenHeight - keyboardHeight) * 0.945;
    } else {
      return screenHeight * 0.8;
    }
  }
}
