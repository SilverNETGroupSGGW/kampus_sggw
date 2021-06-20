import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kampus_sggw/models/campus_rules.dart';
import 'package:kampus_sggw/translations/locale_keys.g.dart';
import 'build_list_title_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'link_to_campus_rules_widget.dart';

class RulesWidget extends StatefulWidget {
  final String currentLang;

  RulesWidget(this.currentLang);

  @override
  _RulesWidget createState() => _RulesWidget();
}

class _RulesWidget extends State<RulesWidget> with TickerProviderStateMixin {
  CampusRules rulesList;
  AnimationController controller;

  @override
  initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      rulesList = await this.loadFromJson(widget.currentLang);
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

  Future<CampusRules> loadFromJson(String lang) async {
    Map<String, dynamic> campusRulesMap =
        jsonDecode(await CampusRules.getJsonSting(lang));
    final campusRules = CampusRules.fromJson(campusRulesMap);
    return campusRules;
  }

  @override
  Widget build(BuildContext context) {
    if (rulesList == null) {
      return Center(
        child: CircularProgressIndicator(
          value: controller.value,
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(
          LocaleKeys.campus_rules.tr(),
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headline3,
        ),
        backgroundColor: Theme.of(context).bannerTheme.backgroundColor,
      ),
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          for (CampusRule campusRule in rulesList.campusRulesList)
            SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: buildListTitle(context, campusRule),
            ),
          ListTile(
            title: LinkToCampusRules(widget.currentLang),
          )
        ],
      ),
    );
  }
}
