import 'package:kampus_sggw/models/map_item.dart';
import 'package:kampus_sggw/models/role.dart';
class UserSettings {
  List<MapItemType> selectedFilters;
  Role role;
  UserSettings({
    this.selectedFilters,
    this.role,
  });
}
