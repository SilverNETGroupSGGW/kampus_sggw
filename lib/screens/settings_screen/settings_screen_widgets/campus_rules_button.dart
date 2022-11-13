import 'package:flutter/material.dart';
import 'package:kampus_sggw/screens/rules_screen/rules_loader.dart';
import 'package:kampus_sggw/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';

class CampusRulesButton extends StatelessWidget {
  const CampusRulesButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        LocaleKeys.drawer_campus_rules.tr(),
        textAlign: TextAlign.center,
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RulesBuilder(),
          ),
        );
      },
    );
  }
}
