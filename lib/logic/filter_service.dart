import 'package:kampus_sggw/models/map_item.dart';

class FilterService {
  String filterName;
  List<MapItem> filteredMapItems;
  FilterService({
    this.filterName,
    this.filteredMapItems,
  });
}
