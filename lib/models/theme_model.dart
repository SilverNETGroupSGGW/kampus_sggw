import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:kampus_sggw/logic/JSON_services/loadable_JSON.dart';
import 'package:kampus_sggw/logic/JSON_services/storable_JSON.dart';
import 'package:kampus_sggw/themes/dark_theme.dart';
import 'package:kampus_sggw/themes/light_theme.dart';
part 'theme_model.g.dart';

@JsonSerializable()
class ThemeModel extends ChangeNotifier with StorableJSON, LoadableJSON {
  @JsonKey(defaultValue: 0)
  int themeId;
  @JsonKey(ignore: true)
  ThemeData _currentTheme;

  ThemeData get currentTheme => _currentTheme;

  ThemeModel({this.themeId});

  factory ThemeModel.fromJson(Map<String, dynamic> json) =>
      _$ThemeModelFromJson(json);

  Map<String, dynamic> toJson() => _$ThemeModelToJson(this);

  void swithTheme() {
    if (themeId == 0) {
      _currentTheme = DarkTheme().theme;
      themeId = 1;
    } else {
      _currentTheme = LightTheme().theme;
      themeId = 0;
    }
    _save();

    return notifyListeners();
  }

  bool isModeDark() => themeId == 1 ? true : false;

  void _save() async {
    super.saveToJson('theme');
  }

  void _initializeTheme() =>
      _currentTheme = themeId == 0 ? LightTheme().theme : DarkTheme().theme;

  static Future<ThemeModel> loadFromJSON() async {
    String jsonString = await LoadableJSON.getJSONString('theme');
    Map<String, dynamic> map = jsonDecode(jsonString);
    ThemeModel themeModel = ThemeModel.fromJson(map);
    themeModel._initializeTheme();
    return themeModel;
  }
}
