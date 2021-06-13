import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kampus_sggw/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';

class SettingsCard extends StatefulWidget {
  @override
  _SettingsCardState createState() => _SettingsCardState();
}

class _SettingsCardState extends State<SettingsCard>{
  bool darkMode = true;
  String language = 'pl';

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
                  value: darkMode,
                  onChanged: (value){
                    setState(() {
                      darkMode = value;
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
              children: <Widget>[
                RadioListTile(
                    title: Text(
                      LocaleKeys.polish.tr(),
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                    value: 'pl',
                    groupValue: language,
                    onChanged: (value) {
                      setState(() {
                        language = value;
                        context.locale = Locale(value);
                      });
                    },
                ),
                RadioListTile(
                  title: Text(
                    LocaleKeys.english.tr(),
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                  value: 'en',
                  groupValue: language,
                  onChanged: (value) {
                    setState(() {
                      language = value;
                      context.locale = Locale(value);
                    });
                  },
                ),
              ],
            ),
          ),
        ]
      ),
    );
  }
}