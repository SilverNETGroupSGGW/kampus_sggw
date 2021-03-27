import 'package:flutter/material.dart';
import 'screens/map_screen/map_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kampus SGGW',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: MapScreen(),
    );
  }
}
