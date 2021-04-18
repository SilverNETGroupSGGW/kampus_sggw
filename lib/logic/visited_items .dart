import 'package:flutter/cupertino.dart';
import 'package:kampus_sggw/models/map_items.dart';

class VisitedItems {
  int buffer;
  List<int> _visitedItemsIds;
  List<String> visitedItems;
  MapItems mapItems;
  VisitedItems({
    @required this.buffer,
    @required this.mapItems,
  });

  void updateVisitedItems() =>
      visitedItems = mapItems.getItemsNames(_visitedItemsIds).reversed.toList();

  void addItem(int id) {
    if (_visitedItemsIds.contains(id)) {
      deleteItem(id);
    }
    _visitedItemsIds.add(id);
    if (_visitedItemsIds.length > buffer) {
      _visitedItemsIds.removeRange(0, 1);
    }
    updateVisitedItems();
  }

  void deleteItem(int id) {
    _visitedItemsIds.removeWhere((i) => i == id);
    updateVisitedItems();
  }
}
