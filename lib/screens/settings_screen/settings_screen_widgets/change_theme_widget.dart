import 'package:flutter/material.dart';
import 'package:kampus_sggw/models/theme_model.dart';
import 'package:provider/provider.dart';

class ChangeThemeWidget extends StatefulWidget {
  @override
  _ChangeThemeWidget createState() => _ChangeThemeWidget();
}

class _ChangeThemeWidget extends State<ChangeThemeWidget> {
  bool _isModeDarkSwitchValue;
  ThemeModel _theme;

  @override
  initState() {
    super.initState();
    _theme = Provider.of<ThemeModel>(context, listen: false);
    _isModeDarkSwitchValue = _theme.isModeDark();
  }

  @override
  Widget build(BuildContext context) {
    return Switch(
      value: _isModeDarkSwitchValue,
      onChanged: (value) {
        _theme.switchTheme();
        _isModeDarkSwitchValue = value;
      },
      activeTrackColor: Colors.white,
      activeColor: Colors.grey,
    );
  }
}
