// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'campus_rules.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CampusRules _$CampusRulesFromJson(Map<String, dynamic> json) {
  return CampusRules(
    json['name'] as String,
    json['lang'] as String,
    (json['campusRulesList'] as List)
        ?.map((e) =>
            e == null ? null : CampusRule.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

CampusRule _$CampusRuleFromJson(Map<String, dynamic> json) {
  return CampusRule(
    json['ruleNumber'] as int,
    json['rule'] as String,
    (json['subRulesList'] as List)
        ?.map((e) => e == null
            ? null
            : CampusSubRule.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

CampusSubRule _$CampusSubRuleFromJson(Map<String, dynamic> json) {
  return CampusSubRule(
    json['subRuleNumber'] as int,
    json['subRule'] as String,
  );
}
