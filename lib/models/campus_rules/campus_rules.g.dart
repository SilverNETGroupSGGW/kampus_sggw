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
