import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kampus_sggw/logic/histories/search_history.dart';
import 'package:kampus_sggw/logic/keyboard_utils.dart';
import 'package:kampus_sggw/logic/search_services/search_service.dart';
import 'package:kampus_sggw/logic/search_services/suggestion_service.dart';
import 'package:kampus_sggw/models/map_item.dart';
import 'package:kampus_sggw/models/map_items.dart';
import 'package:kampus_sggw/screens/map_screen/search_widgets/history_tile.dart';
import 'package:kampus_sggw/screens/map_screen/search_widgets/no_item_found_alert_dialog.dart';
import 'package:kampus_sggw/screens/map_screen/search_widgets/search_help_panel.dart';
import 'package:kampus_sggw/screens/map_screen/search_widgets/suggestion_tile.dart';
import 'package:provider/provider.dart';
import 'package:kampus_sggw/translations/locale_keys.g.dart';

class SearchBar extends StatefulWidget {
  @override
  _SearchBar createState() => _SearchBar();
}

class _SearchBar extends State<SearchBar> {
  MapItem? _firstSuggestion;
  final _focusNode = FocusNode();
  late SearchHistory _searchHistoryProvider;
  var _queryController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Provider.of<SuggestionService>(context, listen: false).resetSuggestions();
    _searchHistoryProvider = Provider.of<SearchHistory>(context, listen: false);
    _searchHistoryProvider.loadMapItems(
      Provider.of<MapItems>(context, listen: false),
    );
    _queryController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _queryController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _searchBox(),
        _panelWithSuggestionOrHelp(),
      ],
    );
  }

  Container _searchBox() {
    return Container(
      margin: EdgeInsets.all(4.0),
      decoration: BoxDecoration(
        color: Theme.of(context).focusColor,
        borderRadius: BorderRadius.all(Radius.circular(8)),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).primaryColor,
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: <Widget>[
          _backArrow(),
          Expanded(
            child: _textField(),
          ),
          _suffixIconButton()
        ],
      ),
    );
  }

  IconButton _backArrow() {
    return IconButton(
      splashColor: Colors.grey,
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        if (KeyboardUtils.isOpen(context)) {
          _focusNode.unfocus();
          _queryController.clear();
        } else {
          Navigator.pop(context);
        }
      },
    );
  }

  IconButton _suffixIconButton() {
    if (_queryController.text.length == 0) {
      return IconButton(
        onPressed: () {
          if (KeyboardUtils.isOpen(context)) {
            _focusNode.unfocus();
          } else {
            _focusNode.requestFocus();
          }
        },
        icon: Icon(Icons.search),
      );
    } else {
      return IconButton(
        onPressed: () {
          _queryController.clear();
          _onQueryChanged("");
        },
        icon: Icon(Icons.clear),
      );
    }
  }

  TextField _textField() {
    return TextField(
      focusNode: _focusNode,
      cursorColor: Colors.blue,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.go,
      controller: _queryController,
      onChanged: (query) => _onQueryChanged(query),
      onSubmitted: (_) => _onSubmitted(_),
      decoration: InputDecoration(
        border: InputBorder.none,
        contentPadding: EdgeInsets.symmetric(horizontal: 15),
        hintText: LocaleKeys.search_bar_title.tr(),
      ),
    );
  }

  Container _suggestionPanel() {
    return Container(
      margin: EdgeInsets.all(4.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Material(
          color: Theme.of(context).focusColor,
          elevation: 4,
          child: Builder(
            builder: (context) {
              return _suggestionColumn();
            },
          ),
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
      _firstSuggestion = suggestions.first.item!.mapItem;
    } else {
      _firstSuggestion = null;
    }
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: displayedSuggestions,
    );
  }

  Widget _panelWithSuggestionOrHelp() {
    if (KeyboardUtils.isOpen(context)) {
      return Stack(
        children: [
          _searchHelpPanelBackgroud(),
          _suggestionPanel(),
        ],
      );
    } else {
      return SearchHelpPanel();
    }
  }

  GestureDetector _searchHelpPanelBackgroud() {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      child: IgnorePointer(
        child: Opacity(
          opacity: 0.4,
          child: SearchHelpPanel(),
        ),
      ),
      onTap: () {
        _focusNode.unfocus();
        _queryController.clear();
      },
    );
  }

  void _onQueryChanged(String query) {
    Provider.of<SuggestionService>(context, listen: false)
        .suggestItemsMatchingQuery(query);
    _searchHistoryProvider.filter(query);
  }

  void _onSubmitted(String query) {
    if (_firstSuggestion == null) {
      _queryController.clear();
      _showAlertNoItemFound();
    } else {
      _search(_firstSuggestion!);
    }
  }

  void _search(MapItem item) {
    _searchHistoryProvider.addItem(item);
    Provider.of<SearchService>(context, listen: false).showSearchedItem(item);
  }

  void _showAlertNoItemFound() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return NoItemFoundAlertDialog();
      },
    );
  }
}
