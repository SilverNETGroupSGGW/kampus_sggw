import 'package:flutter/material.dart';
import 'package:kampus_sggw/models/theme_model.dart';
import 'package:kampus_sggw/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';

class ChangeThemeWidget extends StatefulWidget {
  @override
  _ChangeThemeWidget createState() => _ChangeThemeWidget();
}

class _ChangeThemeWidget extends State<ChangeThemeWidget> {
  late bool _isModeDarkSwitchValue;
  late ThemeModel _theme;

  @override
  initState() {
    super.initState();
    _theme = Provider.of<ThemeModel>(context, listen: false);
    _isModeDarkSwitchValue = _theme.isModeDark();
  }

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      title: Text(LocaleKeys.dark_mode.tr()),
      value: _isModeDarkSwitchValue,
      onChanged: (value) {
        _theme.switchTheme();
        _isModeDarkSwitchValue = value;
      },
      activeTrackColor: Colors.white,
      activeColor: Colors.green,
    );
  }
}
