// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'campus_rules.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CampusRules _$CampusRulesFromJson(Map<String, dynamic> json) => CampusRules(
      json['name'] as String?,
      json['lang'] as String?,
      (json['campusRulesList'] as List<dynamic>?)
          ?.map((e) => CampusRule.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CampusRulesToJson(CampusRules instance) =>
    <String, dynamic>{
      'name': instance.name,
      'lang': instance.lang,
      'campusRulesList': instance.campusRulesList,
    };
