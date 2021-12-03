import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:kampus_sggw/global_widgets/clickable_url.dart';
import 'package:kampus_sggw/models/service.dart';
import 'package:kampus_sggw/translations/locale_keys.g.dart';

class ServiceCard extends StatelessWidget {
  final Service? service;
  ServiceCard({this.service});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SimpleDialog(
        title: Text(
          service!.name!,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.subtitle1,
        ),
        children: _dialogChildren(context),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
        ),
      ),
    );
  }

  List<Widget> _dialogChildren(BuildContext context) {
    List<Widget> widgets = [];

    if (service!.photoPath != null) {
      widgets.add(
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: ClipRect(
            child: Image.asset(service!.photoPath!),
          ),
        ),
      );
    }
    if (service!.description != null) {
      widgets.add(
        Padding(
          padding: const EdgeInsets.only(
            bottom: 15,
            left: 22,
            right: 22,
            top: 5,
          ),
          child: Text(
            service!.description!,
            textAlign: TextAlign.center,
          ),
        ),
      );
    }
    if (service!.url != null) {
      widgets.add(
        ClickableUrl(url: service!.url),
      );
    }

    widgets.add(
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
    );

    return widgets;
  }
}
