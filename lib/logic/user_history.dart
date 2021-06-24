import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:kampus_sggw/models/map_item.dart';
import 'package:kampus_sggw/models/map_items.dart';
import 'package:provider/provider.dart';
part 'user_history.g.dart';

@JsonSerializable()
class UserHistory {
  @JsonKey(defaultValue: 6)
  int buffer;
  @JsonKey(defaultValue: <int>[])
  List<int> itemsIds;

  UserHistory({this.buffer, this.itemsIds});

  factory UserHistory.fromJson(Map<String, dynamic> json) =>
      _$UserHistoryFromJson(json);

  @protected
  List<MapItem> updateMapItems(BuildContext context) {
    List<MapItem> mapItems =
        Provider.of<MapItems>(context, listen: false).getItems(itemsIds);
    return mapItems.reversed.toList();
  }

  void addItem(MapItem mapItem) {
    _putAtFirstPosition(mapItem);
    itemsIds.add(mapItem.id);
    _trimListToBuffer();
  }

  void _trimListToBuffer() {
    if (itemsIds.length > buffer) {
      itemsIds.removeRange(0, 1);
    }
  }

  void _putAtFirstPosition(MapItem mapItem) {
    deleteItem(mapItem);
  }

  void deleteItem(MapItem mapItem) {
    itemsIds.removeWhere((item) => item == mapItem.id);
  }
}
