import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class StorableJson {
  Map<String, dynamic> toJson();

  @protected
  void saveToJson(String sharedPrefKey) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String jsonString = jsonEncode(this.toJson());
    await sharedPreferences.setString(sharedPrefKey, jsonString);
  }
}
