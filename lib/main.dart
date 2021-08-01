import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kampus_sggw/logic/histories/search_history.dart';
import 'package:kampus_sggw/logic/histories/visit_history.dart';
import 'package:kampus_sggw/logic/map_controller.dart';
import 'package:kampus_sggw/logic/map_icons_controller.dart';
import 'package:kampus_sggw/logic/search_services/fiter_service.dart';
import 'package:kampus_sggw/logic/search_services/search_service.dart';
import 'package:kampus_sggw/logic/search_services/suggestion_service.dart';
import 'package:kampus_sggw/models/map_items.dart';
import 'package:kampus_sggw/models/theme_model.dart';
import 'package:kampus_sggw/logic/search_bar_controller.dart';
import 'package:kampus_sggw/logic/map_markers_controller.dart';
import 'package:kampus_sggw/screens/map_screen/map_screen.dart';
import 'package:kampus_sggw/translations/codegen_loader.g.dart';
import 'package:kampus_sggw/updateLocalData.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await GetStorage.init();

  await checkUpdates();

  final mapItems = await MapItems.load();
  final searchHistory = await SearchHistory.loadFromJSON();
  final visitHistory = await VisitHistory.loadFromJSON();
  final themeModel = await ThemeModel.loadFromJSON();
  final mapController = MapController();
  final markersConroller = MapMarkersConroller(
    mapController: mapController,
    iconsController: await MapIconsController.loadIcons(),
  );
  final searchService = SearchService(
    mapMarkers: markersConroller,
  );
  final filterService = FilterService(
    mapItems: mapItems,
    searchService: searchService,
  );
  final suggestionService = SuggestionService(
    mapItems: mapItems,
  );

  runApp(
    EasyLocalization(
      supportedLocales: [Locale('en'), Locale('pl')],
      path: 'assets/translations',
      fallbackLocale: Locale('pl'),
      startLocale: Locale('pl'),
      assetLoader: CodegenLoader(),
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: mapItems),
          ChangeNotifierProvider.value(value: searchHistory),
          ChangeNotifierProvider.value(value: visitHistory),
          ChangeNotifierProvider.value(value: themeModel),
          ChangeNotifierProvider.value(value: searchService),
          ChangeNotifierProvider.value(value: filterService),
          ChangeNotifierProvider.value(value: suggestionService),
          ChangeNotifierProvider.value(value: mapController),
          ChangeNotifierProvider.value(value: markersConroller),
          ChangeNotifierProvider(
            create: (_) => SearchBarController(),
          ),
        ],
        child: CampusSGGW(),
      ),
    ),
  );
}

class CampusSGGW extends StatefulWidget {
  @override
  _CampusSGGWState createState() => _CampusSGGWState();
}

class _CampusSGGWState extends State<CampusSGGW> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return MaterialApp(
      title: 'Kampus SGGW',
      theme: Provider.of<ThemeModel>(context).currentTheme,
      home: MapScreen(),
      supportedLocales: context.supportedLocales,
      localizationsDelegates: context.localizationDelegates,
      locale: context.locale,
    );
  }
}
