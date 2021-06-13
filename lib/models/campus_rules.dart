import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class campusRules {
  String name;
  String lang;
  List<campusRule> campusRulesList;
}

@JsonSerializable()
class campusRule {
  int ruleNumber;
  String rule;
  List<campusSubRule> subRulesList;
}

@JsonSerializable()
class campusSubRule {
  int subRuleNumber;
  String subRule;
}