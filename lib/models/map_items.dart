import 'map_item.dart';
import 'map_item_type.dart';

class MapItems {
  List<MapItem> mapItems;
  MapItems({
    this.mapItems,
  });
  List<MapItem> filter(List<MapItemType> types) =>
      mapItems.where((element) => types.contains(element.type));
  List<String> getItemsNames(List<int> itemsIds) => mapItems
      .where((item) => itemsIds.contains(item.id))
      .map((item) => item.name)
      .toList();
}
