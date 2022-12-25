import 'package:flutter/material.dart';
import 'package:kampus_sggw/logic/search_services/search_service.dart';

class SearchButtonController extends ChangeNotifier {
  FloatingActionButton? _button;
  Function? _onSearchButtonPressed;
  Function? _collapseBottomDrawer;
  late SearchService _searchService;
  bool _areMarkersFiltered = false;

  FloatingActionButton? get button => _button;
  bool get areMarkersFiltered => _areMarkersFiltered;

  SearchButtonController({
    required SearchService searchService,
    Function? onSearchButtonPressed,
    Function? collapseBottomDrawerFunc,
  }) {
    _searchService = searchService;
    searchService.searchButtonController = this;
    _onSearchButtonPressed = onSearchButtonPressed;
    _collapseBottomDrawer = collapseBottomDrawerFunc;
    _button = _searchButton();
  }

  FloatingActionButton _searchButton() {
    return FloatingActionButton(
      child: const Icon(Icons.search),
      backgroundColor: Colors.green,
      onPressed: () => _onSearchButtonPressed!(),
    );
  }

  FloatingActionButton _unfilterButton(String filterName) {
    _areMarkersFiltered = true;
    return FloatingActionButton.extended(
      onPressed: () => _restoreToDefault(),
      label: Container(
        constraints: BoxConstraints(maxWidth: 200),
        child: Text(
          filterName,
          overflow: TextOverflow.fade,
          softWrap: false,
          style: TextStyle(
            fontFamily: 'SGGWSans',
            fontSize: 20,
          ),
        ),
      ),
      icon: const Icon(Icons.clear),
      backgroundColor: Colors.green,
    );
  }

  void showUnfilterButton(String filterName) {
    _collapseBottomDrawer!();
    _button = _unfilterButton(filterName);
    return notifyListeners();
  }

  void restoreMarkersWithReturnButton() => _restoreToDefault();

  void _restoreToDefault() {
    _searchService.resetMarkers();
    _button = _searchButton();
    _areMarkersFiltered = false;
    return notifyListeners();
  }
}
