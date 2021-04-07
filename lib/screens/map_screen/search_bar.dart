import 'package:flutter/material.dart';
import 'package:kampus_sggw/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';

class SearchBar extends StatefulWidget {
  @override
  _SearchBar createState() => _SearchBar();
}

class _SearchBar extends State<SearchBar> {
  List<String> _searchHistory = [
    '1st',
    '2nd',
    '3rd',
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
          child: FilterFloatingButtons(),
        ),
        transition: CircularFloatingSearchBarTransition(),
        physics: BouncingScrollPhysics(),
        title: Text(
          selectedTerm ?? LocaleKeys.search_bar_title.tr(),
          style: Theme.of(context).textTheme.headline6,
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
            borderRadius: BorderRadius.circular(8),
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
                            leading: const Icon(Icons.history),
                            trailing: IconButton(
                              icon: const Icon(Icons.clear),
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

class FilterFloatingButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final fsb = FloatingSearchBar.of(context);
    return Container(
      padding: EdgeInsets.only(top: fsb.height + fsb.margins.vertical + 10.0),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                LocaleKeys.find_nearby.tr(),
                style: Theme.of(context).textTheme.subtitle1,
              ),
            ),
          ),
          Divider(color: Colors.grey[900]),
          Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 5),
              ),
              Container(
                height: 65.0,
                width: 65.0,
                child: FloatingActionButton(
                  child: const Icon(
                    Icons.restaurant,
                    size: 35.0,
                  ),
                  backgroundColor: Colors.yellow[700],
                  onPressed: () {},
                ),
              ),
              Padding(
                padding: EdgeInsets.all(5),
              ),
              Container(
                height: 65.0,
                width: 65.0,
                child: FloatingActionButton(
                  child: const Icon(Icons.bus_alert, size: 35.0),
                  backgroundColor: Colors.blue,
                  onPressed: () {},
                ),
              ),
              Padding(
                padding: EdgeInsets.all(5),
              ),
              Container(
                height: 65.0,
                width: 65.0,
                child: FloatingActionButton(
                  child: const Icon(Icons.local_parking, size: 35.0),
                  backgroundColor: Colors.orange,
                  onPressed: () {},
                ),
              ),
              Padding(
                padding: EdgeInsets.all(5),
              ),
              Container(
                height: 65.0,
                width: 65.0,
                child: FloatingActionButton(
                  child: const Icon(Icons.park, size: 35.0),
                  backgroundColor: Colors.green,
                  onPressed: () {},
                ),
              ),
              Padding(
                padding: EdgeInsets.all(5),
              ),
              Container(
                height: 65.0,
                width: 65.0,
                child: FloatingActionButton(
                  child: const Icon(Icons.local_grocery_store, size: 35.0),
                  backgroundColor: Colors.red[300],
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
