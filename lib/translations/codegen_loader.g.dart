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

  static const Map<String,dynamic> en = {
  "map_screen_title": "SGGW Campus"
};
static const Map<String,dynamic> pl = {
  "map_screen_title": "Kampus SGGW"
};
static const Map<String, Map<String,dynamic>> mapLocales = {"en": en, "pl": pl};
}
