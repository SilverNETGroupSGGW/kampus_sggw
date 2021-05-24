import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingsCard extends StatefulWidget {
  //TODO: 1. Poprawienie bledu przy nawigacji
  @override
  _SettingsCardState createState() => _SettingsCardState();
}

class _SettingsCardState extends State<SettingsCard> {
  final rule1 = "I. Kampus Uczelni jest terenem ogólnodostępnym w godz. od 6:00 do 22:00. W pozostałym przedziale czasowym na terenie Kampusu mogą przebywać tylko osob do tego uprawnione:";
  final rule2 = "II. Każdy kto przebywa na terenie Kampusu SGGW zobowiązany jest do:";
  final rule3 = "III. Na terenie Kampusu zabrania się: ";
  final rule4 = "IV. Osoby odpowiedzialne za sprawowanie nadzoru na terenie Kampusu SGGW. a szczególnie pracownicy Straży Akademickiej oraz monitoringu obiektów są uprawnione i zobowiązane do:";
  final subItems = {'rule1': 4, 'rule2': 5, 'rule3': 8, 'rule4': 4};
  final List<String> subRules1 = ['1) pracownicy Uczelni (a także osoby im towarzyszące) oraz osoby wykonujące prace zlecone na rzecz Uczelni posiadające indywidualne zezwolenia;','2) studenci i doktoranci SGGW oraz osoby im towarzyszące;', '3) mieszkańcy domów studenckich. Domu Asystenckiego i Pokoi Gościnnych Ikar:', '4) osoby korzystające z obiektów usługowych na terenie Kampusu do czasu ich zamknięcia.'];
  final List<String> subRules2 = ['1) przestrzegania ogólnie przyjętych norm postępowania w zakresie relacji międzyludzkich:','2) przestrzegania zasad poszanowania mienia wspólnego Uczelni, poszanowania zieleni, a zwłaszcza niezaśmiecania Kampusu;', '3) właściwego korzystania z urządzeń, instalacji oraz wyposażenia budynków z uwzględnieniem ich przeznaczenia;', '4) właściwego korzystania z dróg transportu samochodowego, parkingów dla samochodów oraz chodników dla pieszych;','5) zachowania zwykłych i nakazanych środków ostrożności przy trzymaniu psów oraz przy trzymaniu innych zwierząt.'];
  final List<String> subRules3 = ['1) zakłócania porządku publicznego, agresywnego, napastliwego i nieobyczajnego zachowania oraz niszczenia mienia Uczelni;','2) spożywania alkoholu (nie dotyczy lokali konsumpcyjnych znajdujących się na terenie Kampusu SGGW oraz wydarzeń okazjonalnych lub cyklicznych organizowanych na terenie Kampusu SGGW, pod warunkiem wyrażenia przez Władze Uczelni zgody na spożywanie alkoholu podczas takiego wydarzenia), przebywania w stanie nietrzeźwym oraz pod wpływem innych środków odurzających;', '3) wnoszenia i posiadania broni (z wyłączeniem osób pełniących służbę ochrony) i innych przedmiotów mogących stanowić zagrożenie bezpieczeństwa, w szczególności: materiałów wybuchowych, wyrobów pirotechnicznych, środków odurzających lub psychotropowych;', '4) organizowania ognisk;', '5) grillowania poza miejscami do tego wyznaczonymi;', '6) wyprowadzania psów bez smyczy i kagańców oraz pozastawiania ich bez opieki;', '7) parkowania pojazdów poza wyznaczonymi miejscami;', '8) prowadzenia handlu obwoźnego i akwizycji bez zgody Władz Uczelni.'];
  final List<String> subRules4 = ['1) ograniczania wstępu na teren Kampusu osobom nieupoważnionym, a w przypadku ujawnienia naruszeń postanowień Regulaminu żądania opuszczenia terenu Kampusu;','2) zwracania szczególnej uwagi na osoby, które swoim zachowaniem budzą uzasadnione podejrzenia zakłócenia porządku publicznego i reagowania w sytuacjach zagrożenia;', '3) współdziałania, zgodnie z Prawem o Szkolnictwie Wyższym i Statutem Uczelni, w zakresie bezpieczeństwa z właściwymi terenowo jednostkami Policji. Straży Miejskiej, a w przypadku jakiegokolwiek zagrożenia wezwania grup interwencyjnych czy innych służb miejskich lub ratunkowych (Straż Pożarna. Pogotowie Ratunkowe);', '4) kontrolowania uprawnień do przebywania na terenie Kampusu SGGW.'];

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
            child: buildListTitle(context, rule1, subRules1),
          ),
          SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: buildListTitle(context, rule2, subRules2),
          ),
          SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: buildListTitle(context, rule3, subRules3),
          ),
          SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: buildListTitle(context, rule4, subRules4),
          ),
        ],
      ),
    );
  }

  Widget buildListTitle(BuildContext context, final text, List<String> subRules) => ExpansionTile(
    title: Text(
      text,
      style: Theme.of(context).textTheme.headline4,
    ),
    children: [
      for (var subRule in subRules)
        ListTile(
          title:
          Text(
            subRule,
            style: Theme.of(context).textTheme.headline4,
          ),
        )
    ],
  );
}




