import 'package:flutter/material.dart';
import 'package:kampus_sggw/translations/locale_keys.g.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'visit_history_list.dart';
import 'filter_buttons_row.dart';

class SearchHelpPanel extends StatelessWidget {
  final Function onFilterButtonPressed;
  final Function onItemTilePressed;
  const SearchHelpPanel({
    Key key,
    @required this.onFilterButtonPressed,
    @required this.onItemTilePressed,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final fsb = FloatingSearchBar.of(context);
    return Container(
      padding: EdgeInsets.only(
        top: fsb.height + fsb.margins.vertical + 5,
      ),
      child: Column(
        children: [
          Headline(
            text: LocaleKeys.find_nearby.tr(),
          ),
          FilterButtonsRow(
            onButtonPressed: onFilterButtonPressed,
          ),
          Headline(
            text: LocaleKeys.recent_searches.tr(),
          ),
          VisitHistoryList(
            onItemTilePressed: onItemTilePressed,
          ),
        ],
      ),
    );
  }
}

class Headline extends StatelessWidget {
  final text;

  const Headline({Key key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.only(
              left: 10,
            ),
            child: Text(
              text,
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ),
        ),
        Divider(
          color: Colors.grey[600],
          thickness: 1,
        ),
      ],
    );
  }
}
