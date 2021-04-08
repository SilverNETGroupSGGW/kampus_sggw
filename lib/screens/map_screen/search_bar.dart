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
          child: FilterFloatingButtons(
            searchHistory: _searchHistory,
          ),
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
  final searchHistory;

  const FilterFloatingButtons({
    Key key,
    @required this.searchHistory,
  }) : super(key: key);

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
          Divider(color: Colors.black),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: EdgeInsets.only(top: 5, bottom: 8),
              child: Padding(
                padding: EdgeInsets.only(left:15),
                child:Row(
                children: <Widget>[
                  Container(
                    height: 60.0,
                    width: 60.0,
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
                    padding: EdgeInsets.only(left: 10),
                  ),
                  Container(
                    height: 60.0,
                    width: 60.0,
                    child: FloatingActionButton(
                      child: const Icon(Icons.bus_alert, size: 35.0),
                      backgroundColor: Colors.blue,
                      onPressed: () {},
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10),
                  ),
                  Container(
                    height: 60.0,
                    width: 60.0,
                    child: FloatingActionButton(
                      child: const Icon(Icons.local_parking, size: 35.0),
                      backgroundColor: Colors.orange,
                      onPressed: () {},
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10),
                  ),
                  Container(
                    height: 60.0,
                    width: 60.0,
                    child: FloatingActionButton(
                      child: const Icon(Icons.park, size: 35.0),
                      backgroundColor: Colors.green,
                      onPressed: () {},
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10),
                  ),
                  Container(
                    height: 60.0,
                    width: 60.0,
                    child: FloatingActionButton(
                      child: const Icon(Icons.local_grocery_store, size: 35.0),
                      backgroundColor: Colors.red[300],
                      onPressed: () {},
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10),
                  ),
                  Container(
                    height: 60.0,
                    width: 60.0,
                    child: FloatingActionButton(
                      child: const Icon(Icons.print_rounded, size: 35.0),
                      backgroundColor: Colors.indigo,
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ),
          ),),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 10, top: 15),
              child: Text(
                LocaleKeys.recent_searches.tr(),
                style: Theme.of(context).textTheme.subtitle1,
              ),
            ),
          ),
          Divider(color: Colors.black),
          Padding(
            padding: EdgeInsets.only(left:15, top: 2),
            child: Column(
              children: <Widget>[
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    searchHistory[0],
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
                Padding(
            padding: EdgeInsets.only(bottom:4, top: 4),
            child: Divider(color: Colors.grey,),),
                
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    searchHistory[1],
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
                Padding(
            padding: EdgeInsets.only(bottom:4, top: 4),
            child: Divider(color: Colors.grey,),),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    searchHistory[2],
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
                Padding(
            padding: EdgeInsets.only(bottom:4, top: 4),
            child: Divider(color: Colors.grey,),),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    searchHistory[3],
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
                Padding(
            padding: EdgeInsets.only(bottom:4, top: 4),
            child: Divider(color: Colors.grey,),),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
