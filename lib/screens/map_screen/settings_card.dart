import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingsCard extends StatefulWidget {
  //TODO: 1. Poprawienie bledu przy nawigacji
  //TODO: 2. wyświetlanie podpunktów
  @override
  _SettingsCardState createState() => _SettingsCardState();
}

class _SettingsCardState extends State<SettingsCard> {
  final rule1 = "1. Kampus Uczelni jest terenem ogólnodostępnym w godz. od 6:00 do 22:00. W pozostałym przedziale czasowym na terenie Kampusu mogą przebywać tylko osob do tego uprawnione:";
  final rule2 = "2. Każdy kto przebywa na terenie Kampusu SGGW zobowiązany jest do:";
  final rule3 = "3. Na terenie Kampusu zabrania się: ";
  final rule4 = "4. Osoby odpowiedzialne za sprawowanie nadzoru na terenie Kampusu SGGW. a szczególnie pracownicy Straży Akademickiej oraz monitoringu obiektów są uprawnione i zobowiązane do:";
  final subItems = {'rule1': 4, 'rule2': 5, 'rule3': 8, 'rule4': 4};

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            height: 90.0,
            child: DrawerHeader(
              child: Text(
                  "Regulamin Kampusu",
                  textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline3),
              decoration: BoxDecoration(
                  color: Theme.of(context).bannerTheme.backgroundColor
              ),
            ),
          ),
          SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: buildListTitle(context, rule1),
          ),
          SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: buildListTitle(context, rule2),
          ),
          SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: buildListTitle(context, rule3),
          ),
          SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: buildListTitle(context, rule4),
          ),
        ],
      ),
    );
  }

  Widget buildListTitle(BuildContext context, final text) => ExpansionTile(
    title: Text(
      text,
      style: Theme.of(context).textTheme.headline4,
    ),
    children: [
      ListTile(
        title:
        Text(
          '1) pracownicy Uczelni (a także osoby im towarzyszące) oraz osoby wykonujące prace zlecone na rzecz Uczelni posiadające indywidualne zezwolenia;',
          style: Theme.of(context).textTheme.headline4,
        ),
      )
    ],
  );
}




