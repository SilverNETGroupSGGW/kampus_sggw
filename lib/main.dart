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

class CampusSGGW extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kampus SGGW',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: MapScreen(
        mapItems: mapItems,
        searchHistory: searchHistory,
        visitedItems: visitedItems,
      ),
      supportedLocales: context.supportedLocales,
      localizationsDelegates: context.localizationDelegates,
      locale: context.locale,
    );
  }
}
