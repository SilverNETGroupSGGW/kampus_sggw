import 'package:flutter/material.dart';
import 'package:kampus_sggw/screens/settings_screen/settings_screen.dart';

class SettingsIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.settings),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SettingsScreen(),
          ),
        );
      },
    );
  }
}
