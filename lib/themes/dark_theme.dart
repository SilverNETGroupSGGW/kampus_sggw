import 'package:flutter/material.dart';

class DarkTheme {
  ThemeData get theme => ThemeData.dark().copyWith(
      primaryColor: Colors.grey[900],
      backgroundColor: Colors.grey[900],
      brightness: Brightness.dark,
      focusColor: Colors.grey[800],
      textTheme: TextTheme(
        button: TextStyle(color: Colors.white),
        headline1: TextStyle(
          fontFamily: 'SGGWMastro',
          fontSize: 48.0,
          color: Colors.white,
        ),
        headline2: TextStyle(
          fontFamily: 'SGGWMastro',
          fontSize: 32.0,
          color: Colors.white,
        ),
        headline3: TextStyle(
          fontFamily: 'SGGWMastro',
          fontSize: 24.0,
          color: Colors.white,
        ),
        headline4: TextStyle(
          fontFamily: 'SGGWMastro',
          fontSize: 18.0,
          color: Colors.white,
        ),
        headline5: TextStyle(
          fontFamily: 'SGGWMastro',
          fontSize: 16.0,
          color: Colors.white,
        ),
        headline6: TextStyle(
          fontFamily: 'SGGWMastro',
          fontSize: 14.0,
          color: Colors.white,
        ),
        subtitle1: TextStyle(
          fontFamily: 'SGGWSans',
          fontSize: 18.0,
          color: Colors.white,
        ),
        subtitle2: TextStyle(
          fontFamily: 'SGGWSans',
          color: Colors.white,
        ),
        bodyText1: TextStyle(
          fontFamily: 'SGGWSans',
          color: Colors.white,
        ),
        bodyText2: TextStyle(
          fontFamily: 'SGGWSans',
          color: Colors.white,
        ),
      ),
      bannerTheme: MaterialBannerThemeData(
        backgroundColor: Color.fromRGBO(50, 118, 57, 1),
        contentTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 16,
        ),
      ),
      toggleableActiveColor: Colors.black,
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: Colors.green[900],
        foregroundColor: Colors.white,
      ),
      appBarTheme: AppBarTheme(
        color: Color.fromRGBO(50, 118, 57, 1),
        titleTextStyle: TextStyle(
          fontFamily: 'SGGWSans',
          fontSize: 20,
        ),
      ),
      dividerColor: Colors.white60);
}
