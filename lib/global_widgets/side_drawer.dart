import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:kampus_sggw/screens/map_screen/rules_card.dart';
import 'package:kampus_sggw/screens/map_screen/settings_card.dart';
import 'package:kampus_sggw/translations/locale_keys.g.dart';

class SideDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            height: 120.0,
            child: DrawerHeader(
              child: Text(LocaleKeys.map_screen_title.tr(), style: TextStyle(color: Theme.of(context).bannerTheme.contentTextStyle.color),),
              decoration: BoxDecoration(
                color: Theme.of(context).bannerTheme.backgroundColor
              ),
            ),
          ),
          ListTile(
            title: Text(
              LocaleKeys.drawer_settings.tr(),
              style: Theme.of(context).textTheme.subtitle2,
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SettingsCard())
              );
            },
          ),
          ListTile(
            title: Text(
              LocaleKeys.drawer_campus_rules.tr(),
              style: Theme.of(context).textTheme.subtitle2,
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RulesCard()),
              );
            },
          ),
        ],
      ),
    );
  }
}
