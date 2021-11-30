import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:kampus_sggw/translations/locale_keys.g.dart';

class PhotoCard extends StatelessWidget {
  final Image? image;
  final String? heading;
  PhotoCard({this.image, this.heading});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SimpleDialog(
        title: Text(
          heading!,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 26,
              fontFamily: 'SGGWMastro'),
        ),
        children: [
          InteractiveViewer(child: image!),
          Padding(
            padding: const EdgeInsets.only(right: 16.0, left: 16.0),
            child: Align(
              alignment: Alignment.bottomRight,
              child: TextButton(
                style: ButtonStyle(
                  animationDuration: Duration(milliseconds: 0),
                ),
                onPressed: () => Navigator.pop(context),
                child: Text(LocaleKeys.close.tr()),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
