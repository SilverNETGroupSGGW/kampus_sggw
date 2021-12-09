import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:kampus_sggw/global_widgets/clickable_url.dart';
import 'package:kampus_sggw/models/campus_rules/campus_rule.dart';
import 'package:kampus_sggw/models/campus_rules/campus_rules.dart';
import 'package:kampus_sggw/translations/locale_keys.g.dart';
import 'rules_screen_widgets/build_list_title_widget.dart';
import 'package:easy_localization/easy_localization.dart';

class RulesScreen extends StatefulWidget {
  final String currentLang;

  RulesScreen(this.currentLang);

  @override
  _RulesScreenState createState() => _RulesScreenState();
}

class _RulesScreenState extends State<RulesScreen>
    with TickerProviderStateMixin {
  CampusRules? rulesList;
  late AnimationController controller;

  @override
  initState() {
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
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
          style: TextStyle(
            fontFamily: 'SGGWSans',
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 2),
        children: [
          for (CampusRule campusRule in rulesList!.campusRulesList!)
            SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: buildListTitle(context, campusRule),
            ),
          ListTile(
            title: ClickableUrl(
              url: _fullRulesLink(),
              text: LocaleKeys.rules_link.tr(),
              includeHeader: false,
            ),
          ),
        ],
      ),
    );
  }

  String _fullRulesLink() {
    switch (widget.currentLang) {
      case "pl":
        return "http://adiss.sggw.pl/wp-content/uploads/2017/06/R_p_K.17.pdf";
      case "en":
        return "http://adiss.sggw.pl/wp-content/uploads/2019/10/Reg_EN.pdf";
      default:
        return "http://adiss.sggw.pl/regulaminy/";
    }
  }
}
