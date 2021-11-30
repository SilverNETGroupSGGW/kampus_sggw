// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'campus_rule.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CampusRule _$CampusRuleFromJson(Map<String, dynamic> json) => CampusRule(
      json['ruleNumber'] as int?,
      json['rule'] as String?,
      (json['subRulesList'] as List<dynamic>?)
          ?.map((e) => CampusSubRule.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CampusRuleToJson(CampusRule instance) =>
    <String, dynamic>{
      'ruleNumber': instance.ruleNumber,
      'rule': instance.rule,
      'subRulesList': instance.subRulesList,
    };
