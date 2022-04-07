import 'package:flutter/material.dart';
import 'package:kampus_sggw/screens/creators_screen/creators_screen.dart';
import 'package:kampus_sggw/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';

class AuthorsButton extends StatelessWidget {
  const AuthorsButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        LocaleKeys.authors.tr(),
        textAlign: TextAlign.center,
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CreatorsScreen(),
          ),
        );
      },
    );
  }
}
