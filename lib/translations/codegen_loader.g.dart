// DO NOT EDIT. This is code generated via package:easy_localization/generate.dart

// ignore_for_file: prefer_single_quotes

import 'dart:ui';

import 'package:easy_localization/easy_localization.dart' show AssetLoader;

class CodegenLoader extends AssetLoader{
  const CodegenLoader();

  @override
  Future<Map<String, dynamic>> load(String fullPath, Locale locale ) {
    return Future.value(mapLocales[locale.toString()]);
  }

  static const Map<String,dynamic> pl = {
  "map_screen_title": "Kampus SGGW",
  "drawer_settings": "Ustawienia",
  "drawer_campus_rules": "Regulamin kampusu",
  "search_bar_title": "Szukaj miejsca lub adresu",
  "find_nearby": "Szukaj w pobliżu",
  "recent": "Ostatnio odwiedzone",
  "recent_searches": "Ostatnio odwiedzone",
  "food": "Restauracje",
  "bus": "Transport publiczny",
  "parking": "Parkingi",
  "park": "Parki i pomniki",
  "store": "Sklepy",
  "copier": "Ksero",
  "no_results_found": "Nie znaleziono wyników wyszukiwania",
  "other_institutions": "Pozostałe instytucje",
  "floor_plans": "Mapy pięter",
  "photo": "Zdjęcie",
  "gallery": "Galeria",
  "departments": "Katedry",
  "institutes": "Instytuty",
  "faculties": "Wydziały",
  "floor": "Piętro",
  "website": "Strona internetowa",
  "offices": "Biura",
  "close": "Zamknij"
};
static const Map<String,dynamic> en = {
  "map_screen_title": "SGGW Campus",
  "drawer_settings": "Settings",
  "drawer_campus_rules": "Campus rules",
  "search_bar_title": "Search for a place or address",
  "find_nearby": "Find Nearby",
  "recent": "Recent",
  "recent_searches": "Recent",
  "food": "Restaurants",
  "bus": "Public Transport",
  "parking": "Car parks",
  "park": "Parks and Monuments",
  "store": "Stores",
  "copier": "Copier",
  "no_results_found": "No search results found",
  "other_institutions": "Other institutions",
  "floor_plans": "Floor plans",
  "photo": "Photo",
  "gallery": "Gallery",
  "departments": "Departments",
  "institutes": "Institutes",
  "faculties": "Faculties",
  "floor": "Floor",
  "website": "Website",
  "offices": "Offices",
  "close": "Close"
};
static const Map<String, Map<String,dynamic>> mapLocales = {"pl": pl, "en": en};
}
