import 'package:flutter/material.dart';
import 'package:kampus_sggw/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';

class NoItemFoundAlertDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        LocaleKeys.no_results_found.tr(),
        style: TextStyle(
          fontFamily: 'SGGWSans',
          fontSize: 20,
        ),
      ),
      actions: [
        TextButton(
          style: ButtonStyle(animationDuration: Duration(milliseconds: 0)),
          onPressed: () => Navigator.pop(context),
          child: Text(
            LocaleKeys.close.tr(),
            style: TextStyle(
              fontFamily: 'SGGWSans',
              fontSize: 18,
            ),
          ),
        ),
      ],
      shape:
          RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10)),
    );
  }
}
