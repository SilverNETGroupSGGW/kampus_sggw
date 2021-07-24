import 'package:flutter/material.dart';
import 'package:kampus_sggw/logic/search_services/suggested_item.dart';

class SuggestionTile extends StatelessWidget {
  final SuggestedItem item;
  final Function onTap;

  const SuggestionTile({
    Key key,
    this.item,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        item.matchedQuery,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        item.mapItem.name,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      leading: Icon(Icons.pin_drop),
      onTap: () => onTap(item.mapItem),
    );
  }
}
