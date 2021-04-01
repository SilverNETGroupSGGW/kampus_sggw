import 'map_item_type.dart';
import 'role.dart';

class UserSettings {
  List<MapItemType> selectedFilters;
  Role role;
  UserSettings({
    this.selectedFilters,
    this.role,
  });
}
