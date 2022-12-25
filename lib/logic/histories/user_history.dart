import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:kampus_sggw/models/map_item.dart';
import 'package:kampus_sggw/models/map_items.dart';

@JsonSerializable()
class UserHistory extends ChangeNotifier {
  @JsonKey(defaultValue: 6)
  int? buffer;
  @JsonKey(defaultValue: <int>[])
  List<int?>? itemsIds;
  @JsonKey(ignore: true)
  late List<MapItem> _storedMapItems;

  UserHistory({this.buffer, this.itemsIds});

  UnmodifiableListView<MapItem> get storedMapItems =>
      UnmodifiableListView(_storedMapItems);

  void loadMapItems(MapItems mapItems) {
    _storedMapItems = mapItems.getItemsMappedWithId(itemsIds!).reversed.toList();
  }

  @protected
  void addItem(MapItem mapItem) {
    _putAtFirstPosition(mapItem);
    itemsIds!.add(mapItem.id);
    _trimListToBuffer();
  }

  @protected
  void deleteItem(MapItem? mapItem) {
    itemsIds!.removeWhere((id) => id == mapItem!.id);
    _storedMapItems.removeWhere((item) => item.id == mapItem!.id);
  }

  void _trimListToBuffer() {
    if (itemsIds!.length > buffer!) {
      itemsIds!.removeRange(0, 1);
    }
  }

  void _putAtFirstPosition(MapItem mapItem) {
    itemsIds!.removeWhere((id) => id == mapItem.id);
  }
}
