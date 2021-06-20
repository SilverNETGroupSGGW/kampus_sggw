import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:kampus_sggw/translations/locale_keys.g.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:easy_localization/easy_localization.dart';

class LinkToCampusRules extends StatelessWidget {
  final String currentLang;
  LinkToCampusRules(this.currentLang);

  String returnUrl(String lang) {
    switch(lang) {
      case "pl":
        return "http://adiss.sggw.pl/wp-content/uploads/2017/06/R_p_K.17.pdf";
      case "en":
        return "http://adiss.sggw.pl/wp-content/uploads/2019/10/Reg_EN.pdf";
      default:
        return "http://adiss.sggw.pl/regulaminy/";
    }
  }

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: LocaleKeys.rules_link.tr(),
            style: Theme.of(context).textTheme.headline4,
            recognizer: TapGestureRecognizer()
              ..onTap = () async {
                if (await canLaunch(returnUrl(currentLang))) {
                  await launch(
                    returnUrl(currentLang),
                    forceSafariVC: false,
                  );
                }
              },
          ),
        ],
      ),
    );
  }
}
