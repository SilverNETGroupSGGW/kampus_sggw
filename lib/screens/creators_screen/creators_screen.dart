import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:kampus_sggw/models/author.dart';
import 'package:kampus_sggw/models/authors.dart';
import 'package:kampus_sggw/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';

class CreatorsScreen extends StatefulWidget {
  const CreatorsScreen({Key? key}) : super(key: key);

  @override
  State<CreatorsScreen> createState() => _CreatorsScreenState();
}

class _CreatorsScreenState extends State<CreatorsScreen> {
  Authors authors = Authors('', '', []);

  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      authors = await this.loadFromJson(context.locale.toString());
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          LocaleKeys.authors.tr(),
        ),
      ),
      body: ListView(
        children: authorsList(authors),
      ),
    );
  }

  List<Widget> authorsList(Authors authors) {
    List<ListTile> _authorsList = [];
    for (Author author in authors.authorsList!) {
      _authorsList.add(authorTile(role: author.role, name: author.name));
    }
    return _authorsList;
  }

  ListTile authorTile({String? role, String? name}) {
    return ListTile(
      horizontalTitleGap: 0.0,
      title: Text(
        '$name',
        overflow: TextOverflow.fade,
        softWrap: false,
        style: TextStyle(fontSize: 18),
      ),
      subtitle: Text(
        '$role',
        overflow: TextOverflow.fade,
        softWrap: false,
        style: TextStyle(fontSize: 12),
      ),
      dense: true,
    );
  }

  Future<Authors> loadFromJson(String lang) async {
    Map<String, dynamic> authorsMap = jsonDecode(await Authors.getJsonSting(lang));
    final authors = Authors.fromJson(authorsMap);
    return authors;
  }
}
