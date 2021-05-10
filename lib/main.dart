import 'dart:convert';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kampus_sggw/logic/search_history.dart';
import 'package:kampus_sggw/logic/visited_items.dart';
import 'package:kampus_sggw/models/map_items.dart';
import 'package:kampus_sggw/screens/map_screen/map_screen.dart';
import 'package:kampus_sggw/translations/codegen_loader.g.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  Map<String, dynamic> mapItemsMap = jsonDecode(await MapItems.getJsonSting());
  final mapItems = MapItems.fromJson(mapItemsMap);
  Map<String, dynamic> searchHistoryMap =
      jsonDecode(await SearchHistory.getJsonSting());
  final searchHistory = SearchHistory.fromJson(searchHistoryMap);
  Map<String, dynamic> visitedItemsMap =
      jsonDecode(await VisitedItems.getJsonSting());
  final visitedItems = VisitedItems.fromJson(visitedItemsMap);
  visitedItems.mapItems = mapItems;

  runApp(
    EasyLocalization(
        supportedLocales: [Locale('en'), Locale('pl')],
        path: 'assets/translations',
        fallbackLocale: Locale('pl'),
        startLocale: Locale('pl'),
        assetLoader: CodegenLoader(),
        child: CampusSGGW(
          mapItems: mapItems,
          searchHistory: searchHistory,
          visitedItems: visitedItems,
        )),
  );
}

class CampusSGGW extends StatefulWidget {
  final MapItems mapItems;
  final SearchHistory searchHistory;
  final VisitedItems visitedItems;
  const CampusSGGW({
    Key key,
    this.mapItems,
    this.searchHistory,
    this.visitedItems,
  }) : super(key: key);

  @override
  _CampusSGGWState createState() => _CampusSGGWState();
}

class _CampusSGGWState extends State<CampusSGGW> {
  bool _hasDarkTheme = true;

  ThemeData _lightTheme = ThemeData.light().copyWith(
    primaryColor: Colors.green,
    accentColor: Colors.green,
    brightness: Brightness.light,
    floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: Colors.lightGreen, foregroundColor: Colors.white),
    textTheme: TextTheme(
      headline1: TextStyle(
          fontFamily: 'SGGWMastro', fontSize: 48.0, color: Colors.black),
      headline2: TextStyle(
          fontFamily: 'SGGWMastro', fontSize: 32.0, color: Colors.black),
      headline3: TextStyle(
          fontFamily: 'SGGWMastro', fontSize: 24.0, color: Colors.black),
      headline4: TextStyle(
          fontFamily: 'SGGWMastro', fontSize: 18.0, color: Colors.black),
      headline5: TextStyle(
          fontFamily: 'SGGWMastro', fontSize: 16.0, color: Colors.black),
      headline6: TextStyle(
          fontFamily: 'SGGWMastro', fontSize: 14.0, color: Colors.black),
      subtitle1: TextStyle(
          fontFamily: 'SGGWSans', fontSize: 18.0, color: Colors.black),
      subtitle2: TextStyle(fontFamily: 'SGGWSans', color: Colors.black),
      bodyText1: TextStyle(fontFamily: 'SGGWSans', color: Colors.black),
      bodyText2: TextStyle(fontFamily: 'SGGWSans', color: Colors.black),
    ),
    textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all<Color>(Colors.green))),
    bannerTheme: MaterialBannerThemeData(
        backgroundColor: Color.fromRGBO(110, 200, 80, 1),
        contentTextStyle: TextStyle(color: Colors.black)),
  );

  ThemeData _darkTheme = ThemeData.dark().copyWith(
      primaryColor: Colors.grey[900],
      brightness: Brightness.dark,
      accentColor: Colors.white,
      focusColor: Colors.grey[800],
      textTheme: TextTheme(
        button: TextStyle(color: Colors.white),
        headline1: TextStyle(
            fontFamily: 'SGGWMastro', fontSize: 48.0, color: Colors.white),
        headline2: TextStyle(
            fontFamily: 'SGGWMastro', fontSize: 32.0, color: Colors.white),
        headline3: TextStyle(
            fontFamily: 'SGGWMastro', fontSize: 24.0, color: Colors.white),
        headline4: TextStyle(
            fontFamily: 'SGGWMastro', fontSize: 18.0, color: Colors.white),
        headline5: TextStyle(
            fontFamily: 'SGGWMastro', fontSize: 16.0, color: Colors.white),
        headline6: TextStyle(
            fontFamily: 'SGGWMastro', fontSize: 14.0, color: Colors.white),
        subtitle1: TextStyle(
            fontFamily: 'SGGWSans', fontSize: 18.0, color: Colors.white),
        subtitle2: TextStyle(fontFamily: 'SGGWSans', color: Colors.white),
        bodyText1: TextStyle(fontFamily: 'SGGWSans', color: Colors.white),
        bodyText2: TextStyle(fontFamily: 'SGGWSans', color: Colors.white),
      ),
      bannerTheme: MaterialBannerThemeData(
        backgroundColor: Color.fromRGBO(50, 118, 57, 1),
        contentTextStyle: TextStyle(color: Colors.white),
      ),
      toggleableActiveColor: Colors.black,
      floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Colors.green[900], foregroundColor: Colors.white),
      dividerColor: Colors.white60);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kampus SGGW',
      theme: _lightTheme,
      darkTheme: _darkTheme,
      themeMode: _hasDarkTheme ? ThemeMode.dark : ThemeMode.light,
      home: MapScreen(
        mapItems: widget.mapItems,
        searchHistory: widget.searchHistory,
        visitedItems: widget.visitedItems,
      ),
      supportedLocales: context.supportedLocales,
      localizationsDelegates: context.localizationDelegates,
      locale: context.locale,
    );
  }
}
