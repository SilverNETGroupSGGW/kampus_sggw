import 'dart:convert';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:kampus_sggw/logic/search_history.dart';
import 'package:kampus_sggw/screens/map_screen/search_help_panel.dart';
import 'package:kampus_sggw/translations/locale_keys.g.dart';

class SearchBar extends StatefulWidget {
  final SearchHistory searchHistory;
  const SearchBar({
    Key key,
    @required this.searchHistory,
  }) : super(key: key);
  @override
  _SearchBar createState() => _SearchBar();
}

class _SearchBar extends State<SearchBar> {
  List<String> _filteredSearchHistory;
  String _selectedTerm;
  FloatingSearchBarController _controller;

  @override
  void initState() {
    super.initState();
    _controller = FloatingSearchBarController();
    _filteredSearchHistory = widget.searchHistory.filterSearchTerms(null);
  }

  @override
  void dispose() {
    String jsonString = jsonEncode(widget.searchHistory);
    SearchHistory.saveJsonString(jsonString);
    _controller.dispose();
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
            child: SearchHelpPanel(),
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
        onQueryChanged: (query) => setState(
          () => updateFilteredSearchHistory(query),
        ),
        onSubmitted: (query) {
          setState(
            () {
              _selectedTerm = query;
              widget.searchHistory.addSearchTerm(query);
              updateFilteredSearchHistory(null);
            },
          );
          _controller.close();
        },
        builder: (context, transition) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Material(
              color: Colors.white,
              elevation: 4,
              child: Builder(
                builder: (context) {
                  if (_filteredSearchHistory.isEmpty &&
                      _controller.query.isNotEmpty) {
                    return suggestedSearchHistoryListTile();
                  } else {
                    return searchHistoryColumn();
                  }
                },
              ),
            ),
          );
        },
      ),
    );
  }

  void updateFilteredSearchHistory(filter) =>
      _filteredSearchHistory = widget.searchHistory.filterSearchTerms(filter);

  Column searchHistoryColumn() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: _filteredSearchHistory
          .map(
            (term) => ListTile(
              title: Text(
                term,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              leading: const Icon(Icons.history),
              trailing: IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () {
                  setState(() {
                    widget.searchHistory.deleteSearchTerm(term);
                    updateFilteredSearchHistory(null);
                  });
                },
              ),
              onTap: () {
                setState(() {
                  widget.searchHistory.addSearchTerm(term);
                  _selectedTerm = term;
                  updateFilteredSearchHistory(null);
                });
                _controller.close();
              },
            ),
          )
          .toList(),
    );
  }

  ListTile suggestedSearchHistoryListTile() {
    return ListTile(
      title: Text(_controller.query),
      leading: const Icon(Icons.search),
      onTap: () {
        setState(() {
          widget.searchHistory.addSearchTerm(_controller.query);
          _selectedTerm = _controller.query;
          updateFilteredSearchHistory(null);
        });
        _controller.close();
      },
    );
  }
}
