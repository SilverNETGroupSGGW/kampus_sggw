import 'package:flutter/material.dart';
import 'package:kampus_sggw/screens/map_screen/search_help_panel.dart';
import 'package:kampus_sggw/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';

class SearchBar extends StatefulWidget {
  @override
  _SearchBar createState() => _SearchBar();
}

class _SearchBar extends State<SearchBar> {
  List<String> _searchHistory = [
    'first option',
    'random second option Nowoursynowska 11b, 03-200 Warszawa',
    '3rd list tile Nowoursynowska 11b, 03-200 Warszawa',
    '4th element',
    '5th element',
  ];

  String selectedTerm;

  FloatingSearchBarController controller;

  @override
  void initState() {
    super.initState();
    controller = FloatingSearchBarController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FloatingSearchBar(
        controller: controller,
        body: FloatingSearchBarScrollNotifier(
          child: SearchHelpPanel(
            searchHistory: _searchHistory,
          ),
        ),
        transition: CircularFloatingSearchBarTransition(),
        physics: BouncingScrollPhysics(),
        title: Text(
          selectedTerm ?? LocaleKeys.search_bar_title.tr(),
        ),
        onQueryChanged: (query) {},
        onSubmitted: (query) {
          setState(() {
            selectedTerm = query;
          });
          controller.close();
        },
        builder: (context, transition) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Material(
              color: Colors.white,
              elevation: 4,
              child: Builder(
                builder: (context) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: _searchHistory
                        .map(
                          (term) => ListTile(
                            title: Text(
                              term,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            leading: Icon(
                              Icons.history,
                            ),
                            trailing: IconButton(
                              icon: Icon(
                                Icons.clear,
                              ),
                              onPressed: () {},
                            ),
                            onTap: () {
                              controller.close();
                            },
                          ),
                        )
                        .toList(),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
