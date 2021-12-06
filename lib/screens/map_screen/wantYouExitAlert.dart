import 'package:flutter/material.dart';
import 'package:kampus_sggw/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';

class wantYouExitAlert extends StatelessWidget{
  const wantYouExitAlert({Key key, this.wantYouExit}) : super(key: key);
  final bool wantYouExit;
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 500),
      child: wantYouExit ? Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Center(
            child: Padding(
              padding: EdgeInsets.all(5),
              child: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: Theme
                        .of(context)
                        .primaryColor
                        .withOpacity(0.9),
                    borderRadius: BorderRadius.circular(1000)
                ),
                child: Text(
                  LocaleKeys.want_you_exit.tr(),
                  style: Theme
                      .of(context)
                      .textTheme
                      .bodyText1,
                ),
              ),
            ),
          ),
        ],
      ) : SizedBox(),);
  }
}