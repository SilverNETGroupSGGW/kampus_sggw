import 'package:flutter/material.dart';
import 'package:kampus_sggw/screens/settings_screen/settings_screen_widgets/authors_button.dart';
import 'package:kampus_sggw/screens/settings_screen/settings_screen_widgets/campus_rules_button.dart';
import 'package:kampus_sggw/screens/settings_screen/settings_screen_widgets/category_container.dart';
import 'package:kampus_sggw/screens/settings_screen/settings_screen_widgets/change_language_widget.dart';
import 'package:kampus_sggw/screens/settings_screen/settings_screen_widgets/change_theme_widget.dart';
import 'package:kampus_sggw/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          LocaleKeys.settings.tr(),
        ),
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      body: Column(
        children: [
          CategoryContainer(
            children: [
              ChangeThemeWidget(),
              ChangeLanguageWidget(),
            ],
          ),
          CategoryContainer(
            children: [
              CampusRulesButton(),
              AuthorsButton()
            ],
          ),
        ],
      ),
    );
  }
}
