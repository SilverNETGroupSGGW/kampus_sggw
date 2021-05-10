import 'package:kampus_sggw/models/map_item.dart';
import 'package:kampus_sggw/models/service.dart';

class FilterButtonService {
  String filterName;
  List<MapItemType> mapItemTypes;
  ServiceType serviceType;
  FilterButtonService({
    this.filterName,
    this.mapItemTypes,
    this.serviceType,
  });
}
