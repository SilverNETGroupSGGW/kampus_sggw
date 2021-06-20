import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../main.dart';

class ChangeThemeWidget extends StatefulWidget {
  @override
  _ChangeThemeWidget createState() => _ChangeThemeWidget();
}

class _ChangeThemeWidget extends State<ChangeThemeWidget> {
  bool _switchStatus;

  @override
  initState() {
    _switchStatus = getDarkModeValue();
    super.initState();
  }

  bool getDarkModeValue() {
    return darkMode == 1;
  }

  void _saveThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('isDarkModeOn', darkMode);
  }

  @override
  Widget build(BuildContext context) {
    return Switch(
      value: _switchStatus,
      onChanged: (value) {
        setState(() {
          {
            Provider.of<ThemeModel>(context, listen: false).toggleTheme();
          }
          if (value == true) darkMode = 1;
          if (value == false) darkMode = 0;
          _switchStatus = getDarkModeValue();
          _saveThemeMode();
        });
      },
      activeTrackColor: Colors.white,
      activeColor: Colors.grey,
    );
  }
}
