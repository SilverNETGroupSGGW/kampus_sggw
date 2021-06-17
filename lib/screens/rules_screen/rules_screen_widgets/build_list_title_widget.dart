import 'package:flutter/material.dart';
import 'package:kampus_sggw/models/campus_rules.dart';

Widget buildListTitle(BuildContext context, CampusRule rule) => ExpansionTile(
  title: Text(
    rule.rule,
    style: Theme.of(context).textTheme.subtitle1,
  ),
  children: [
    for (CampusSubRule subRule in rule.subRulesList)
      ListTile(
        title:
        Text(
          '\t' + subRule.subRule,
          style: Theme.of(context).textTheme.subtitle1,
        ),
      )
  ],
);