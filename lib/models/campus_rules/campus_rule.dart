import 'package:json_annotation/json_annotation.dart';
import 'package:kampus_sggw/models/campus_rules/campus_sub_rule.dart';
part 'campus_rule.g.dart';

@JsonSerializable()
class CampusRule {
  int? ruleNumber;
  String? rule;
  List<CampusSubRule>? subRulesList;
  CampusRule(
    this.ruleNumber,
    this.rule,
    this.subRulesList,
  );
  factory CampusRule.fromJson(Map<String, dynamic> json) =>
      _$CampusRuleFromJson(json);
}
