import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kampus_sggw/logic/histories/search_history.dart';
import 'package:kampus_sggw/logic/search_bar_controller.dart';
import 'package:kampus_sggw/logic/search_services/search_service.dart';
import 'package:kampus_sggw/logic/search_services/suggestion_service.dart';
import 'package:kampus_sggw/models/map_item.dart';
import 'package:kampus_sggw/models/map_items.dart';
import 'package:kampus_sggw/screens/map_screen/search_widgets/history_tile.dart';
import 'package:kampus_sggw/screens/map_screen/search_widgets/no_item_found_alert_dialog.dart';
import 'package:kampus_sggw/screens/map_screen/search_widgets/search_help_panel.dart';
import 'package:kampus_sggw/screens/map_screen/search_widgets/suggestion_tile.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:provider/provider.dart';
import 'package:kampus_sggw/translations/locale_keys.g.dart';

class SearchBar extends StatefulWidget {
  @override
  _SearchBar createState() => _SearchBar();
}

class _SearchBar extends State<SearchBar> {
  MapItem _firstSuggestion;
  SearchHistory _searchHistoryProvider;
  SearchBarController _controllerProvider;

  @override
  void initState() {
    super.initState();
    Provider.of<SuggestionService>(context, listen: false).resetSuggestions();
    _searchHistoryProvider = Provider.of<SearchHistory>(context, listen: false);
    _searchHistoryProvider.loadMapItems(
      Provider.of<MapItems>(context, listen: false),
    );
    _controllerProvider =
        Provider.of<SearchBarController>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: FloatingSearchBar(
        controller: _controllerProvider.controller,
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
          LocaleKeys.search_bar_title.tr(),
          style: TextStyle(fontSize: 20),
        ),
        actions: [
          FloatingSearchBarAction.searchToClear(),
        ],
        onQueryChanged: (query) => _onQueryChanged(query),
        onSubmitted: (_) => _onSubmitted(_),
        builder: (context, transition) => _suggestionPanel(),
      ),
    );
  }

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
    List<Widget> displayedSuggestions = [];
    var _searchedItems =
        Provider.of<SearchHistory>(context, listen: true).filteredHistory.map(
              (itemFromHistory) => HistoryTile(
                item: itemFromHistory,
                onTap: _search,
              ),
            );
    var suggestions = Provider.of<SuggestionService>(context, listen: true)
        .currentSuggestions
        .map(
          (suggestedItem) => SuggestionTile(
            item: suggestedItem,
            onTap: _search,
          ),
        );
    displayedSuggestions.addAll(_searchedItems);
    int leftForDisplaying = 6 - _searchedItems.length;
    if (leftForDisplaying > 0) {
      displayedSuggestions.addAll(suggestions.take(leftForDisplaying));
    }
    if (_searchedItems.isNotEmpty) {
      _firstSuggestion = _searchedItems.first.item;
    } else if (suggestions.isNotEmpty) {
      _firstSuggestion = suggestions.first.item.mapItem;
    } else {
      _firstSuggestion = null;
    }
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: displayedSuggestions,
    );
  }

  void _onQueryChanged(String query) {
    Provider.of<SuggestionService>(context, listen: false)
        .suggestItemsMatchingQuery(query);
    _searchHistoryProvider.filter(query);
  }

  void _onSubmitted(String query) {
    if (_firstSuggestion == null) {
      _showAlertNoItemFound();
    } else {
      _search(_firstSuggestion);
    }
  }

  void _search(MapItem item) {
    _searchHistoryProvider.addItem(item);
    Provider.of<SearchService>(context, listen: false).showSearchedItem(item);
    _controllerProvider.close();
  }

  void _showAlertNoItemFound() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return NoItemFoundAlertDialog();
      },
    );
    _controllerProvider.close();
  }
}
