import 'package:kampus_sggw/models/map_item.dart';
import 'package:kampus_sggw/models/service.dart';

class FiltrationEventParam {
  String filterName;
  List<MapItemType> mapItemTypes;
  List<ServiceType> serviceTypes;
  FiltrationEventParam({
    this.filterName,
    this.mapItemTypes,
    this.serviceTypes,
  });
}
