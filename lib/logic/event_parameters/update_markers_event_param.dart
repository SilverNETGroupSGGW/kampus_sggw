import 'package:kampus_sggw/models/map_item.dart';

class UpdateMarkersEventParam {
  String filterName;
  List<MapItem> filteredMapItems;
  UpdateMarkersEventParam({
    this.filterName,
    this.filteredMapItems,
  });
}
