import 'package:flutter/material.dart';

class LightTheme {
  ThemeData get theme => ThemeData.light().copyWith(
        primaryColor: Colors.grey[400],
        brightness: Brightness.light,
        backgroundColor: Colors.grey[300],
        focusColor: Colors.white,
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Colors.lightGreen,
          foregroundColor: Colors.white,
        ),
        textTheme: TextTheme(
          headline1: TextStyle(
            fontFamily: 'SGGWMastro',
            fontSize: 48.0,
            color: Colors.black,
          ),
          headline2: TextStyle(
            fontFamily: 'SGGWMastro',
            fontSize: 32.0,
            color: Colors.black,
          ),
          headline3: TextStyle(
            fontFamily: 'SGGWMastro',
            fontSize: 24.0,
            color: Colors.black,
          ),
          headline4: TextStyle(
            fontFamily: 'SGGWMastro',
            fontSize: 18.0,
            color: Colors.black,
          ),
          headline5: TextStyle(
            fontFamily: 'SGGWMastro',
            fontSize: 16.0,
            color: Colors.black,
          ),
          headline6: TextStyle(
            fontFamily: 'SGGWMastro',
            fontSize: 14.0,
            color: Colors.black,
          ),
          subtitle1: TextStyle(
            fontFamily: 'SGGWSans',
            fontSize: 18.0,
            color: Colors.black,
          ),
          subtitle2: TextStyle(
            fontFamily: 'SGGWSans',
            color: Colors.black,
          ),
          bodyText1: TextStyle(
            fontFamily: 'SGGWSans',
            color: Colors.black,
          ),
          bodyText2: TextStyle(
            fontFamily: 'SGGWSans',
            color: Colors.black,
          ),
        ),
        textButtonTheme: TextButtonThemeData(
            style: ButtonStyle(
                foregroundColor:
                    MaterialStateProperty.all<Color>(Colors.green))),
        bannerTheme: MaterialBannerThemeData(
          backgroundColor: Color.fromRGBO(110, 200, 80, 1),
          contentTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
        appBarTheme: AppBarTheme(
          color: Color.fromRGBO(110, 200, 80, 1),
          titleTextStyle: TextStyle(
            fontFamily: 'SGGWSans',
            fontSize: 20,
          ),
        ),
      );
}
