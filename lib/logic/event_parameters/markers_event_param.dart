import 'package:kampus_sggw/models/map_item.dart';

class MarkersEventParam {
  String filterName;
  List<MapItem> filteredMapItems;
  MarkersEventParam(
    this.filterName,
    this.filteredMapItems,
  );
}
