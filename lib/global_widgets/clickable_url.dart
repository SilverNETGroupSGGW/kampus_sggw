import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:kampus_sggw/translations/locale_keys.g.dart';
import 'package:url_launcher/url_launcher.dart';

class ClickableUrl extends StatelessWidget {
  final String? url;
  final String text;
  final bool includeHeader;

  ClickableUrl({this.url = "", this.text = "", this.includeHeader = true});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _header(),
        Padding(
          padding: EdgeInsets.only(top: 5, bottom: 10),
          child: GestureDetector(
            onTap: _openUrl,
            child: Text(
              _linkText()!,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.w500,
                fontSize: 16,
                fontFamily: 'SGGWSans',
              ),
            ),
          ),
        )
      ],
    );
  }

  Future<void> _openUrl() async {
    if (await canLaunch(url!)) {
      await launch(url!);
    } else {
      throw 'Could not launch ' + url!;
    }
  }

  Widget _header() {
    if(!includeHeader) {
      return Center();
    }

    return Text(
      LocaleKeys.website.tr(),
      textAlign: TextAlign.center,
      style: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 16,
        fontFamily: 'SGGWSans',
      ),
    );
  }

  String? _linkText() {
    return text == "" ? url : text;
  }
}
