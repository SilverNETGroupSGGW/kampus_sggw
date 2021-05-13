import 'package:kampus_sggw/models/map_item.dart';
import 'package:kampus_sggw/models/service.dart';

class FilterByFunctionEventParam {
  String filterName;
  List<MapItemType> mapItemTypes;
  List<ServiceType> serviceTypes;
  FilterByFunctionEventParam({
    this.filterName,
    this.mapItemTypes,
    this.serviceTypes,
  });
}
