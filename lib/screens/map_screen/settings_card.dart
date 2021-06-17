import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kampus_sggw/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';
import '../../main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsCard extends StatefulWidget {
  @override
  _SettingsCardState createState() => _SettingsCardState();
}

class _SettingsCardState extends State<SettingsCard>{
  String language = 'pl';
  var _languages = ['pl', 'en'];
  bool _darkMode;

  @override
  initState() {
    _darkMode = getDarkModeValue();
    super.initState();
  }

  bool getDarkModeValue(){
    if (darkMode == 1){
      return true;
    }
    else
      return false;
  }

  void _saveThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
      prefs.setInt('isDarkModeOn', darkMode);
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            height: 90.0,
            child: DrawerHeader(
              child: Text(
                  LocaleKeys.settings.tr(),
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline3
              ),
              decoration: BoxDecoration(
                  color: Theme.of(context).bannerTheme.backgroundColor
                ),
            ),
          ),
          ListTile(
            title: Text(
              LocaleKeys.dark_mode.tr(),
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.subtitle1,
            ),
            subtitle: Column(
              children: [
                Switch(
                  value: _darkMode,
                  onChanged: (value){
                    setState(() {
                      {Provider.of<ThemeModel>(context,listen: false).toggleTheme();}
                      if (value == true)
                        darkMode = 1;
                      if (value == false)
                        darkMode = 0;
                      _darkMode = getDarkModeValue();
                      _saveThemeMode();
                    });
                  },
                  activeTrackColor: Colors.black54,
                  activeColor: Colors.black,
                ),
              ],
            ),
          ),
          ListTile(
            title: Text(
              LocaleKeys.language.tr(),
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.subtitle1,
            ),
            subtitle: Column(
              children: [
                DropdownButton<String>(
                  items: _languages.map((String dropDownStringItem) {
                    return DropdownMenuItem<String>(
                      value: dropDownStringItem,
                      child: Text(dropDownStringItem.tr()),
                    );
                  }).toList(),
                  onChanged: (String newValueSelected){
                    setState(() {
                      context.locale = Locale(newValueSelected);
                    });
                  },
                  value: context.locale.toString(),
                )
              ],
            ),
          ),
        ]
      ),
    );
  }
}