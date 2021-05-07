import 'package:kampus_sggw/models/map_item.dart';
import 'package:kampus_sggw/models/service.dart';

class FilterService {
  String filterName;
  MapItemType mapItemType;
  ServiceType serviceType;
  FilterService({
    this.filterName,
    this.mapItemType,
    this.serviceType,
  });
}
