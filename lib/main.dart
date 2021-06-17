import 'dart:convert';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kampus_sggw/logic/search_history.dart';
import 'package:kampus_sggw/models/map_items.dart';
import 'package:kampus_sggw/screens/map_screen/map_screen.dart';
import 'package:kampus_sggw/themes/dark_theme.dart';
import 'package:kampus_sggw/themes/light_theme.dart';
import 'package:kampus_sggw/translations/codegen_loader.g.dart';
import 'package:kampus_sggw/updateLocalData.dart';
import 'package:get_storage/get_storage.dart';

import 'logic/visit_history.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await GetStorage.init();

  await checkUpdates();

  Map<String, dynamic> mapItemsMap = jsonDecode(MapItems.getJsonSting());
  final mapItems = MapItems.fromJson(mapItemsMap);
  mapItems.generateFuzzyStringSetForMapItems();

  Map<String, dynamic> searchHistoryMap =
      jsonDecode(await SearchHistory.getJsonSting());
  final searchHistory = SearchHistory.fromJson(searchHistoryMap);
  searchHistory.mapItems = mapItems;
  searchHistory.updateMapItems();

  Map<String, dynamic> visitHistoryMap =
      jsonDecode(await VisitHistory.getJsonSting());
  final visitHistory = VisitHistory.fromJson(visitHistoryMap);
  visitHistory.mapItems = mapItems;

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
          visitHistory: visitHistory,
        )),
  );
}

class CampusSGGW extends StatefulWidget {
  final MapItems mapItems;
  final SearchHistory searchHistory;
  final VisitHistory visitHistory;
  const CampusSGGW({
    Key key,
    this.mapItems,
    this.searchHistory,
    this.visitHistory,
  }) : super(key: key);

  @override
  _CampusSGGWState createState() => _CampusSGGWState();
}

class _CampusSGGWState extends State<CampusSGGW> {
  bool _hasDarkTheme = true;
  ThemeData _lightTheme = LightTheme().theme;
  ThemeData _darkTheme = DarkTheme().theme;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return MaterialApp(
      title: 'Kampus SGGW',
      theme: _lightTheme,
      darkTheme: _darkTheme,
      themeMode: _hasDarkTheme ? ThemeMode.dark : ThemeMode.light,
      home: MapScreen(
        mapItems: widget.mapItems,
        searchHistory: widget.searchHistory,
        visitHistory: widget.visitHistory,
      ),
      supportedLocales: context.supportedLocales,
      localizationsDelegates: context.localizationDelegates,
      locale: context.locale,
    );
  }
}
