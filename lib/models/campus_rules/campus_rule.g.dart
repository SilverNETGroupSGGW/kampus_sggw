// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'campus_rule.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CampusRule _$CampusRuleFromJson(Map<String, dynamic> json) {
  return CampusRule(
    json['ruleNumber'] as int?,
    json['rule'] as String?,
    (json['subRulesList'] as List?)
        ?.map((e) => e == null
            ? null
            : CampusSubRule.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}
