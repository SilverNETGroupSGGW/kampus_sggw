import 'location.dart';
import 'map_item_type.dart';

class MapItem {
  int id;
  Location geoLocation;
  String name;
  String description;
  String url;
  MapItemType type;
  String photoPath;
  double minScale;
  DateTime lastModified;
  List<String> gallery;
  MapItem({
    this.id,
    this.geoLocation,
    this.name,
    this.description,
    this.url,
    this.type,
    this.photoPath,
    this.minScale,
    this.lastModified,
    this.gallery,
  });
}
