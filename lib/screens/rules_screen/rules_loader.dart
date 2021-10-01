import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:kampus_sggw/screens/rules_screen/rules_screen.dart';

class RulesBuilder extends StatefulWidget {
  @override
  _RulesBuilderState createState() => _RulesBuilderState();
}

class _RulesBuilderState extends State<RulesBuilder> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return RulesScreen(context.locale.toString());
  }
}
