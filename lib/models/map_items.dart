import 'map_item.dart';
import 'map_item_type.dart';

class MapItems {
  List<MapItem> mapItems;
  MapItems({
    this.mapItems,
  });
  List<MapItem> filter(List<MapItemType> types) => mapItems.where((element) => types.contains(element.type));
}
