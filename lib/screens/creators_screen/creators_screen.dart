import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:kampus_sggw/models/autor.dart';
import 'package:kampus_sggw/models/autors.dart';

class CreatorsScreen extends StatefulWidget {
  const CreatorsScreen({Key? key}) : super(key: key);

  @override
  State<CreatorsScreen> createState() => _CreatorsScreenState();
}

class _CreatorsScreenState extends State<CreatorsScreen> {
  Autors autors = Autors('asd', 'asd', []);

  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      autors = await this.loadFromJson();
    });
    autors.autorsList!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Autorzy:',
            style: TextStyle(
              fontFamily: 'SGGWSans',
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        body: ListView(
          children: autorsList(autors),
        ));
  }

  List<Widget> autorsList(Autors autors) {
    List<ListTile> _autorsList = [];
    for (Autor autor in autors.autorsList!) {
      _autorsList.add(autorTile(role: autor.role, name: autor.name));
    }
    return _autorsList;
  }

  ListTile autorTile({String? role, String? name}) {
    return ListTile(
      leading: Icon(Icons.people),
      horizontalTitleGap: 0.0,
      title: Text(
        '${role}: ${name}',
        overflow: TextOverflow.fade,
        softWrap: false,
        style: TextStyle(fontSize: 18),
      ),
      dense: true,
    );
  }

  Future<Autors> loadFromJson() async {
    print('object');
    Map<String, dynamic> autorsMap = jsonDecode(await Autors.getJsonSting());
    final autors = Autors.fromJson(autorsMap);
    return autors;
  }
}
