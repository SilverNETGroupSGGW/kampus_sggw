import 'map_item.dart';
import 'service.dart';

class Building extends MapItem {
  List<Service> services;
  Building({
    this.services,
  });
}
