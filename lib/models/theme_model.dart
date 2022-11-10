import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:kampus_sggw/logic/JSON_services/loadable_JSON.dart';
import 'package:kampus_sggw/logic/JSON_services/storable_JSON.dart';
import 'package:kampus_sggw/themes/dark_theme.dart';
import 'package:kampus_sggw/themes/light_theme.dart';
part 'theme_model.g.dart';

@JsonSerializable()
class ThemeModel extends ChangeNotifier with StorableJson, LoadableJson {
  @JsonKey(defaultValue: 1)
  int? themeId;
  ThemeData? _currentTheme;

  ThemeData? get currentTheme => _currentTheme;

  ThemeModel({this.themeId});

  factory ThemeModel.fromJson(Map<String, dynamic> json) =>
      _$ThemeModelFromJson(json);

  Map<String, dynamic> toJson() => _$ThemeModelToJson(this);

  void switchTheme() {
    if (themeId == 0) {
      themeId = 1;
      _currentTheme = DarkTheme().theme;
    } else {
      themeId = 0;
      _currentTheme = LightTheme().theme;
    }
    _save();

    return notifyListeners();
  }

  bool isModeDark() => themeId == 1;

  void _save() async {
    super.saveToJson('theme');
  }

  void _initializeTheme() =>
      _currentTheme = themeId == 0 ? LightTheme().theme : DarkTheme().theme;

  static Future<ThemeModel> loadFromJson() async {
    String jsonString = await LoadableJson.getJsonString('theme');
    Map<String, dynamic> map = jsonDecode(jsonString);
    ThemeModel themeModel = ThemeModel.fromJson(map);
    themeModel._initializeTheme();
    return themeModel;
  }
}
