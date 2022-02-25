import 'package:flutter/material.dart';

class CreatorsScreen extends StatelessWidget {
  const CreatorsScreen({Key? key}) : super(key: key);

  // late List autors;

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
          children: [autorTile()],
        ));
  }

  ListTile autorTile() {
    return ListTile(
      leading: Icon(Icons.people),
      horizontalTitleGap: 0.0,
      title: Text(
        'autor',
        // item.name!,
        overflow: TextOverflow.fade,
        softWrap: false,
        style: TextStyle(fontSize: 18),
      ),
      dense: true,
    );
  }
}
