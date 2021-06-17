import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class ChangeLanguageWidget extends StatefulWidget {
  @override
  _ChangeLanguageWidget createState() => _ChangeLanguageWidget();
}

class _ChangeLanguageWidget extends State<ChangeLanguageWidget> {
  String language = 'pl';
  var _languages = ['pl', 'en'];
  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
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
    );
  }
}