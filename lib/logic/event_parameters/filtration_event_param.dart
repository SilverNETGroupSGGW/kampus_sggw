import 'package:kampus_sggw/models/map_item_types/map_item_type_category.dart';
import 'package:kampus_sggw/models/service.dart';

class FiltrationEventParam {
  String filterName;
  MapItemTypeCategory category;
  List<ServiceType> serviceTypes;
  FiltrationEventParam({
    this.filterName,
    this.category,
    this.serviceTypes,
  });
}
