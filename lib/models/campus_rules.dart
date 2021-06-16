import 'package:flutter/services.dart';
import 'package:json_annotation/json_annotation.dart';
part 'campus_rules.g.dart';

@JsonSerializable()
class CampusRules {
  String name;
  String lang;
  List<CampusRule> campusRulesList;
  CampusRules(
      this.name,
      this.lang,
      this.campusRulesList,
      );
  factory CampusRules.fromJson(Map<String, dynamic> json) =>
      _$CampusRulesFromJson(json);

  static Future<String> getJsonStingPL() {
    return rootBundle.loadString('assets/json/campus_rules_pl.json');
  }
  static Future<String> getJsonStingEN() {
    return rootBundle.loadString('assets/json/campus_rules_en.json');
  }
}

@JsonSerializable()
class CampusRule {
  int ruleNumber;
  String rule;
  List<CampusSubRule> subRulesList;
  CampusRule(
      this.ruleNumber,
      this.rule,
      this.subRulesList,
      );
  factory CampusRule.fromJson(Map<String, dynamic> json) =>
      _$CampusRuleFromJson(json);
}

@JsonSerializable()
class CampusSubRule {
  int subRuleNumber;
  String subRule;
  CampusSubRule(
      this.subRuleNumber,
      this.subRule,
      );
  factory CampusSubRule.fromJson(Map<String, dynamic> json) =>
      _$CampusSubRuleFromJson(json);
}