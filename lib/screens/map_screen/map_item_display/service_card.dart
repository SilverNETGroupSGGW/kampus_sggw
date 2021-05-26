import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:kampus_sggw/models/service.dart';
import 'package:kampus_sggw/translations/locale_keys.g.dart';
import 'package:url_launcher/url_launcher.dart';

class ServiceCard extends StatelessWidget {
  final Service service;
  ServiceCard({this.service});

  Future<void> _goToServiceURL() async {
    if (await canLaunch(service.url)) {
      await launch(service.url);
    } else {
      throw 'Could not launch ' + service.url;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SimpleDialog(
        title: Text(
          service.name,
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

    if (service.photoPath != null) {
      widgets.add(Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: ClipRect(
          child: Image.asset(service.photoPath),
        ),
      ));
    }
    if (service.description != null) {
      widgets.add(Padding(
        padding: const EdgeInsets.only(
          bottom: 15,
          left: 22,
          right: 22,
          top: 5,
        ),
        child: Text(
          service.description,
          textAlign: TextAlign.center,
        ),
      ));
    }
    if (service.url != null) {
      widgets.add(_serviceUrlWidget(context));
    }

    widgets.add(Padding(
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
    ));

    return widgets;
  }

  Widget _serviceUrlWidget(BuildContext context) {
    return Column(
      children: [
        Divider(
          color: Colors.grey[800],
          thickness: 1.5,
          indent: 12.0,
          endIndent: 12.0,
        ),
        Padding(
          padding: EdgeInsets.only(top: 5),
          child: Text(
            LocaleKeys.website.tr(),
            textAlign: TextAlign.center,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 5),
          child: GestureDetector(
            onTap: _goToServiceURL,
            child: Text(
              service.url,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.blue),
            ),
          ),
        ),
      ],
    );
  }
}
