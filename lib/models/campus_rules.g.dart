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

Map<String, dynamic> _$CampusRulesToJson(CampusRules instance) =>
    <String, dynamic>{
      'name': instance.name,
      'lang': instance.lang,
      'campusRulesList': instance.campusRulesList,
    };

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

Map<String, dynamic> _$CampusRuleToJson(CampusRule instance) =>
    <String, dynamic>{
      'ruleNumber': instance.ruleNumber,
      'rule': instance.rule,
      'subRulesList': instance.subRulesList,
    };

CampusSubRule _$CampusSubRuleFromJson(Map<String, dynamic> json) {
  return CampusSubRule(
    json['subRuleNumber'] as int,
    json['subRule'] as String,
  );
}

Map<String, dynamic> _$CampusSubRuleToJson(CampusSubRule instance) =>
    <String, dynamic>{
      'subRuleNumber': instance.subRuleNumber,
      'subRule': instance.subRule,
    };
