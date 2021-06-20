import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:kampus_sggw/screens/rules_screen/rules_screen_widgets/rules_widget.dart';

class RulesCard extends StatefulWidget {
  @override
  _RulesCardState createState() => _RulesCardState();
}

class _RulesCardState extends State<RulesCard> with TickerProviderStateMixin{
  @override
  Widget build(BuildContext context) {
    return RulesWidget(context.locale.toString());
  }
}
