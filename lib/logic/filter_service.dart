import 'package:kampus_sggw/models/map_item.dart';
import 'package:kampus_sggw/models/service.dart';

class FilterService {
  String filterName;
  List<MapItemType> mapItemTypes;
  ServiceType serviceType;
  FilterService({
    this.filterName,
    this.mapItemTypes,
    this.serviceType,
  });
}
