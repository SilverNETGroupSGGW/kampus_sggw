import 'package:flutter/services.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:kampus_sggw/models/campus_rules/campus_rule.dart';
part 'campus_rules.g.dart';

@JsonSerializable()
class CampusRules {
  String? name;
  String? lang;
  List<CampusRule>? campusRulesList;
  CampusRules(
    this.name,
    this.lang,
    this.campusRulesList,
  );
  factory CampusRules.fromJson(Map<String, dynamic> json) =>
      _$CampusRulesFromJson(json);

  static Future<String> getJsonSting(String lang) {
    return rootBundle.loadString('assets/json/campus_rules_' + lang + '.json');
  }
}
