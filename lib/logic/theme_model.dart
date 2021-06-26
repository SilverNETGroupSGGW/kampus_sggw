import 'package:flutter/material.dart';
import 'package:kampus_sggw/main.dart';

class ThemeModel extends ChangeNotifier {
  ThemeData currentTheme = darkMode == 1 ? darkTheme : lightTheme;
  ThemeType _themeType = darkMode == 1 ? ThemeType.Dark : ThemeType.Light;

  toggleTheme() {
    if (_themeType == ThemeType.Dark) {
      currentTheme = lightTheme;
      _themeType = ThemeType.Light;
    } else if (_themeType == ThemeType.Light) {
      currentTheme = darkTheme;
      _themeType = ThemeType.Dark;
    }

    return notifyListeners();
  }
}
