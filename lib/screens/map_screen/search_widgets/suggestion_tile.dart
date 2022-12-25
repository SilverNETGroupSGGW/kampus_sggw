import 'package:flutter/material.dart';
import 'package:kampus_sggw/logic/event_parameters/suggested_item.dart';

class SuggestionTile extends StatelessWidget {
  final SuggestedItem? item;
  final Function? onTap;

  const SuggestionTile({
    Key? key,
    this.item,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        item!.matchedQuery,
        maxLines: 1,
        overflow: TextOverflow.fade,
        softWrap: false,
      ),
      subtitle: Text(
        item!.mapItem.name!,
        maxLines: 1,
        overflow: TextOverflow.fade,
        softWrap: false,
      ),
      horizontalTitleGap: 0.0,
      leading: Icon(Icons.pin_drop),
      onTap: () => onTap!(item!.mapItem),
    );
  }
}
