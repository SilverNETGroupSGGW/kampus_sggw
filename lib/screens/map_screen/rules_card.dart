import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kampus_sggw/models/campus_rules.dart';
import 'package:kampus_sggw/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';

class RulesCard extends StatefulWidget {
  @override
  _RulesCardState createState() => _RulesCardState();
}

class _RulesCardState extends State<RulesCard> with TickerProviderStateMixin{

  CampusRules rulesListPL;
  CampusRules rulesListEN;
  AnimationController controller;

  @override
  initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async
    {
      rulesListPL = await this.loadFromJsonPL();
      rulesListEN = await this.loadFromJsonEN();
    });

    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..addListener(() {
      setState(() {});
    });
    controller.repeat(reverse: true);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Future<CampusRules> loadFromJsonPL() async {
    Map<String, dynamic> campusRulesMap = jsonDecode(await CampusRules.getJsonStingPL());
    final campusRules = CampusRules.fromJson(campusRulesMap);
    return campusRules;
  }

  Future<CampusRules> loadFromJsonEN() async {
    Map<String, dynamic> campusRulesMap = jsonDecode(await CampusRules.getJsonStingEN());
    final campusRules = CampusRules.fromJson(campusRulesMap);
    return campusRules;
  }

  @override
  Widget build(BuildContext context) {
    if (rulesListPL == null || rulesListEN == null) {
      return Center(
        child: CircularProgressIndicator(
          value: controller.value,
        ),
      );
    }
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            height: 90.0,
            child: DrawerHeader(
              child: Text(
                  LocaleKeys.campus_rules.tr(),
                  textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline3
              ),
              decoration: BoxDecoration(
                  color: Theme.of(context).bannerTheme.backgroundColor
              ),
            ),
          ),
          if (context.locale.toString() == 'pl')
            for (CampusRule campusRule in rulesListPL.campusRulesList)
              SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: buildListTitle(context, campusRule),
              ),
          if (context.locale.toString() == 'en')
            for (CampusRule campusRule in rulesListEN.campusRulesList)
              SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: buildListTitle(context, campusRule),
              ),
        ],
      ),
    );
  }

  Widget buildListTitle(BuildContext context, CampusRule rule) => ExpansionTile(
    title: Text(
      rule.rule,
      style: Theme.of(context).textTheme.headline4,
    ),
    children: [
      for (CampusSubRule subRule in rule.subRulesList)
        ListTile(
          title:
          Text(
            subRule.subRule,
            style: Theme.of(context).textTheme.headline4,
          ),
        )
    ],
  );
}




