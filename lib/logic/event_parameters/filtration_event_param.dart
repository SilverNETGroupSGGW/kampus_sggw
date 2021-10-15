import 'package:kampus_sggw/models/map_object_application.dart';
import 'package:kampus_sggw/models/service.dart';

class FiltrationEventParam {
  String filterName;
  MapObjectApplication objectApplication;
  List<ServiceType> serviceTypes;
  FiltrationEventParam({
    this.filterName,
    this.objectApplication,
    this.serviceTypes,
  });
}
