import 'dart:convert';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kampus_sggw/logic/search_history.dart';
import 'package:kampus_sggw/logic/visited_items.dart';
import 'package:kampus_sggw/models/map_items.dart';
import 'package:kampus_sggw/screens/map_screen/map_screen.dart';
import 'package:kampus_sggw/themes/dark_theme.dart';
import 'package:kampus_sggw/themes/light_theme.dart';
import 'package:kampus_sggw/translations/codegen_loader.g.dart';
import 'package:kampus_sggw/updateLocalData.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  await checkUpdates();

  Map<String, dynamic> mapItemsMap = jsonDecode(await MapItems.getJsonSting());
  final mapItems = MapItems.fromJson(mapItemsMap);
  Map<String, dynamic> searchHistoryMap =
      jsonDecode(await SearchHistory.getJsonSting());
  final searchHistory = SearchHistory.fromJson(searchHistoryMap);
  Map<String, dynamic> visitedItemsMap =
      jsonDecode(await VisitedItems.getJsonSting());
  final visitedItems = VisitedItems.fromJson(visitedItemsMap);
  visitedItems.mapItems = mapItems;
  mapItems.generateFuzzyStringSetForMapItems();

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
        visitedItems: widget.visitedItems,
      ),
      supportedLocales: context.supportedLocales,
      localizationsDelegates: context.localizationDelegates,
      locale: context.locale,
    );
  }
}
