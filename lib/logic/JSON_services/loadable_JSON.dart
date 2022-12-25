import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class LoadableJson {
  @protected
  static Future<String> getJsonString(String sharedPrefKey) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(sharedPrefKey) ?? "{}";
  }
}
