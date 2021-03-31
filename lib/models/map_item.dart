import 'dart:ffi';

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
Float minScale;
DateTime lastModified;
  MapItem({
    this.id,
    this.geoLocation,
    this.name,
    this.description,
    this.url,
    this.photoPath,
    this.minScale,
    this.lastModified,
  });

}
