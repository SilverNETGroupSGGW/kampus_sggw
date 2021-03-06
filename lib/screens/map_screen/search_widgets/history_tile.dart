import 'package:flutter/material.dart';
import 'package:kampus_sggw/logic/histories/search_history.dart';
import 'package:kampus_sggw/models/map_item.dart';
import 'package:provider/provider.dart';

class HistoryTile extends StatelessWidget {
  final MapItem item;
  final Function onTap;

  const HistoryTile({
    Key key,
    this.item,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        item.name,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      leading: Icon(Icons.history),
      trailing: IconButton(
        icon: Icon(Icons.clear),
        onPressed: () =>
            Provider.of<SearchHistory>(context, listen: false).deleteItem(item),
      ),
      onTap: () => onTap(item),
    );
  }
}
