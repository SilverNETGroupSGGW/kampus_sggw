import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kampus_sggw/logic/event_parameters/search_event_param.dart';
import 'package:kampus_sggw/logic/search_services/search_service.dart';
import 'package:kampus_sggw/logic/key_value.dart';
import 'package:kampus_sggw/logic/histories/search_history.dart';
import 'package:kampus_sggw/models/map_item.dart';
import 'package:kampus_sggw/models/map_items.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:provider/provider.dart';
import 'search_help_panel.dart';
import 'package:kampus_sggw/translations/locale_keys.g.dart';

class SearchBar extends StatefulWidget {
  @override
  _SearchBar createState() => _SearchBar();
}

class _SearchBar extends State<SearchBar> {
  SearchService _searchService;
  SearchHistory _searchHistory;
  List<MapItem> _filteredSearchHistory;
  List<KeyValue> _searchSuggestions;
  String _selectedTerm;
  FloatingSearchBarController _controller;
  StreamSubscription _searchSuggestionListener;
  StreamSubscription _searchHistoryListener;

  @override
  void initState() {
    super.initState();
    _controller = FloatingSearchBarController();
    _searchService = Provider.of<SearchService>(context, listen: false);
    _searchHistory = Provider.of<SearchHistory>(context, listen: false);
    _searchHistory.loadMapItems(
      Provider.of<MapItems>(context, listen: false),
    );
    _filteredSearchHistory = _searchHistory.storedMapItems;
    _searchSuggestions = [];
    _searchSuggestionListener = _searchService.searchSuggestionEvent
        .listen((eventParam) => _searchSuggestions = eventParam);
    _searchHistoryListener = _searchService.manageSearchHistoryEvent
        .listen((eventParam) => _addToSearchHistory(eventParam));
  }

  @override
  void dispose() {
    _searchHistory.save();
    _controller.dispose();
    _searchSuggestionListener.cancel();
    _searchHistoryListener.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: FloatingSearchBar(
        controller: _controller,
        body: FloatingSearchBarScrollNotifier(
          child: Padding(
            padding: EdgeInsets.only(
              top: 10.0,
              left: 12.0,
              right: 12.0,
            ),
            child: SearchHelpPanel(
              onItemTilePressed: (eventParam) => _searchService
                  .searchWithMapItemEvent
                  .trigger(param: eventParam),
            ),
          ),
        ),
        transition: CircularFloatingSearchBarTransition(),
        physics: NeverScrollableScrollPhysics(),
        hint: LocaleKeys.search_bar_title.tr(),
        title: Text(
          _selectedTerm ?? LocaleKeys.search_bar_title.tr(),
          style: TextStyle(fontSize: 20),
        ),
        actions: [
          FloatingSearchBarAction.searchToClear(),
        ],
        onQueryChanged: (query) => _onQueryChanged(query),
        onSubmitted: (query) => _onSubmitted(query),
        builder: (context, transition) => _suggestionPanel(),
      ),
    );
  }

  void _updateFilteredSearchHistory({query}) =>
      _filteredSearchHistory = _searchHistory.filterSearchHistory(query: query);

  ClipRRect _suggestionPanel() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: Material(
        elevation: 4,
        child: Builder(
          builder: (context) {
            return _suggestionColumn();
          },
        ),
      ),
    );
  }

  Column _suggestionColumn() {
    List<Widget> _displayedSuggestions = [];
    var _history = _filteredSearchHistory.map((item) => _historyListTile(item));
    var _suggestion = _searchSuggestions.map(
      (suggestion) => _suggestionListTile(suggestion.key, suggestion.value),
    );
    _displayedSuggestions.addAll(_history);
    int leftForDisplaying = 6 - _history.length;
    if (leftForDisplaying > 0) {
      _displayedSuggestions.addAll(_suggestion.take(leftForDisplaying));
    }
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: _displayedSuggestions,
    );
  }

  ListTile _suggestionListTile(MapItem item, String query) {
    return ListTile(
      title: Text(
        query,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        item.name,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      leading: Icon(Icons.pin_drop),
      onTap: () => _onSubmittedWithMapItem(item),
    );
  }

  ListTile _historyListTile(MapItem item) {
    return ListTile(
      title: Text(
        item.name,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      leading: Icon(Icons.history),
      trailing: IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          setState(
            () {
              _deleteFromSearchHistory(item);
            },
          );
        },
      ),
      onTap: () => _onSubmittedWithMapItem(item),
    );
  }

  void _onQueryChanged(String query) {
    setState(() {
      _searchService.searchWithQueryEvent.trigger(
        param: SearchEventParam(query: query, isFinal: false),
      );
      _updateFilteredSearchHistory(query: query);
    });
  }

  void _onSubmitted(String query) {
    setState(() {
      _searchService.searchWithQueryEvent
          .trigger(param: SearchEventParam(query: query, isFinal: true));
    });
    _controller.close();
  }

  void _onSubmittedWithMapItem(MapItem mapItem) {
    setState(() {
      _addToSearchHistory(mapItem);
      _searchService.searchWithMapItemEvent.trigger(param: mapItem);
    });
    _controller.close();
  }

  void _addToSearchHistory(MapItem item) {
    _searchHistory.addItem(item);
    _updateFilteredSearchHistory();
  }

  void _deleteFromSearchHistory(item) {
    _searchHistory.deleteItem(item);
    _updateFilteredSearchHistory();
  }
}
