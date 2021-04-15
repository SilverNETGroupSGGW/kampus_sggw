import 'package:flutter/material.dart';
import 'package:kampus_sggw/models/service.dart';
import 'package:url_launcher/url_launcher.dart';

class ServiceCard extends StatelessWidget {
  final Service service;
  ServiceCard({this.service});

  _goToServiceURL() async {
    if (await canLaunch(service.url)) {
      await launch(service.url);
    } else {
      throw 'Could not launch ' + service.url;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text(service.name),
      children: [
        if (service.photoPath != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: ClipRect(child: Image.asset(service.photoPath)),
          ),
        Padding(
          padding: const EdgeInsets.only(
            bottom: 15,
            left: 22,
            right: 22,
            top: 5,
          ),
          child: Text(service.description),
        ),
        if (service.url != null)
          Padding(
              padding: const EdgeInsets.only(left: 22, right: 22, bottom: 8.0),
              child: GestureDetector(
                  onTap: _goToServiceURL,
                  child: RichText(
                    text: TextSpan(
                      children: [
                        WidgetSpan(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 4.0),
                            child: Icon(Icons.language,
                                size: 20, color: Colors.blue),
                          ),
                        ),
                        TextSpan(
                            text: 'Strona Internetowa',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.blue,
                              decoration: TextDecoration.underline,
                            )),
                      ],
                    ),
                  ))),
      ],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
    );
  }
}
