import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class LoadableJSON {
  @protected
  static Future<String> getJSONString(String sharedPrefKey) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(sharedPrefKey) ?? "{}";
  }
}
