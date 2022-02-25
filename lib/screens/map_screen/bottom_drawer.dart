import 'package:flutter/material.dart';

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
              bottom: MediaQuery.of(context).viewInsets.bottom,
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
    var mediaQuery = MediaQuery.of(context);
    if (mediaQuery.viewInsets.bottom == 0) {
      return mediaQuery.size.height * 0.8;
    } else {
      return (mediaQuery.size.height - mediaQuery.viewInsets.bottom) * 0.945;
    }
  }
}
