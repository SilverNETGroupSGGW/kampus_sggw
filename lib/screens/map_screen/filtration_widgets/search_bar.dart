import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kampus_sggw/logic/event_parameters/search_event_param.dart';
import 'package:kampus_sggw/logic/filtration_service.dart';
import 'package:kampus_sggw/logic/key_value.dart';
import 'package:kampus_sggw/logic/visited_items.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:kampus_sggw/logic/search_history.dart';
import 'search_help_panel.dart';
import 'package:kampus_sggw/translations/locale_keys.g.dart';

class SearchBar extends StatefulWidget {
  final SearchHistory searchHistory;
  final VisitedItems visitedItems;
  final FiltrationService filtrationService;
  const SearchBar({
    Key key,
    @required this.searchHistory,
    @required this.visitedItems,
    @required this.filtrationService,
  }) : super(key: key);
  @override
  _SearchBar createState() => _SearchBar();
}

class _SearchBar extends State<SearchBar> {
  Set<String> _filteredSearchHistory;
  List<KeyValue> _searchSuggestions;
  String _selectedTerm;
  FloatingSearchBarController _controller;
  StreamSubscription _searchSuggestionListener;
  StreamSubscription _searchHistoryListener;

  @override
  void initState() {
    super.initState();
    _controller = FloatingSearchBarController();
    _filteredSearchHistory = widget.searchHistory.filterSearchTerms();
    _searchSuggestions = [];
    _searchSuggestionListener = widget.filtrationService.searchSuggestionEvent
        .listen((eventParam) => _searchSuggestions = eventParam);
    _searchHistoryListener = widget.filtrationService.manageSearchHistoryEvent
        .listen((eventParam) => _addToSearchHistory(eventParam));
  }

  @override
  void dispose() {
    widget.searchHistory.save();
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
              visitedItems: widget.visitedItems,
              onFilterButtonPressed: (eventParam) => widget
                  .filtrationService.filterByFunctionEvent
                  .trigger(param: eventParam),
              onItemTilePressed: (eventParam) => widget
                  .filtrationService.searchWithNameEvent
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

  void _updateFilteredSearchHistory({query}) => _filteredSearchHistory =
      widget.searchHistory.filterSearchTerms(query: query);

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
    var _history = _filteredSearchHistory.map((text) => _historyListTile(text));
    var _suggestion = _searchSuggestions.map(
      (suggestion) =>
          _suggestionListTile(suggestion.key.id, suggestion.value, suggestion.key.name),
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

  ListTile _suggestionListTile(int id, String text, String query) {
    var subtitle = Text(
      query,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
    if (text == query) {
      subtitle = null;
    }
    return _listTile(id, text, Icon(Icons.pin_drop), subtitle: subtitle);
  }

  ListTile _historyListTile(String text) {
    var removeIconButton = IconButton(
      icon: Icon(Icons.clear),
      onPressed: () {
        setState(
          () {
            widget.searchHistory.deleteSearchTerm(text);
            widget.searchHistory.save();
            _updateFilteredSearchHistory();
          },
        );
      },
    );
    return _listTile(0, text, Icon(Icons.history),
        trailingButton: removeIconButton);
  }

  ListTile _listTile(int mapItemID, String text, Icon leadingIcon,
      {Text subtitle, IconButton trailingButton}) {
    return ListTile(
      title: Text(
        text,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: subtitle,
      leading: leadingIcon,
      trailing: trailingButton,
      onTap: () => _onSubmittedWithMapItemID(mapItemID),
    );
  }

  void _onQueryChanged(String query) {
    setState(() {
      widget.filtrationService.searchWithQueryEvent.trigger(
        param: SearchEventParam(query: query, isFinal: false),
      );
      _updateFilteredSearchHistory(query: query);
    });
  }

  void _onSubmitted(String query) {
    setState(() {
      widget.filtrationService.searchWithQueryEvent
          .trigger(param: SearchEventParam(query: query, isFinal: true));
    });
    _controller.close();
  }

  void _onSubmittedWithMapItemID(int mapItemID) {
    setState(() {
      widget.filtrationService.searchWithIDEvent
          .trigger(param: SearchEventParam(id: mapItemID, isFinal: true));
    });
    _controller.close();
  }

  void _addToSearchHistory(String query) {
    widget.searchHistory.addSearchTerm(query);
    widget.searchHistory.save();
  }
}
