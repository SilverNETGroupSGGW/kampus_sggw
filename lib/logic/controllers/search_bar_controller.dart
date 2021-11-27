import 'package:flutter/material.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';

class SearchBarController extends ChangeNotifier {
  FloatingSearchBarController _controller;

  FloatingSearchBarController get controller => _controller;

  SearchBarController() {
    _controller = FloatingSearchBarController();
  }
  void close() => _controller.close();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
