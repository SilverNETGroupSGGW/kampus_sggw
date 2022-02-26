import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:kampus_sggw/translations/locale_keys.g.dart';

class ChangeLanguageWidget extends StatefulWidget {
  @override
  _ChangeLanguageWidget createState() => _ChangeLanguageWidget();
}

class _ChangeLanguageWidget extends State<ChangeLanguageWidget> {
  String language = 'pl';
  var _languages = ['pl', 'en'];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          Text(
            LocaleKeys.language.tr(),
            style: Theme.of(context).textTheme.subtitle1,
          ),
          Spacer(),
          DropdownButton<String>(
            items: _languages.map(
              (String dropDownStringItem) {
                return DropdownMenuItem<String>(
                  value: dropDownStringItem,
                  child: Text(dropDownStringItem.tr()),
                );
              },
            ).toList(),
            onChanged: (String? newValueSelected) {
              setState(() {
                context.setLocale(Locale(newValueSelected!));
              });
            },
            value: context.locale.toString(),
          ),
        ],
      ),
    );
  }
}
