import 'package:json_annotation/json_annotation.dart';
part 'campus_sub_rule.g.dart';

@JsonSerializable()
class CampusSubRule {
  int? subRuleNumber;
  String? subRule;
  CampusSubRule(
    this.subRuleNumber,
    this.subRule,
  );
  factory CampusSubRule.fromJson(Map<String, dynamic> json) =>
      _$CampusSubRuleFromJson(json);
}
