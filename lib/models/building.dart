import 'category.dart';
import 'map_item.dart';
import 'service.dart';

class Building extends MapItem {
  List<Service> services;
  List<Category> categories;
  Building({
    id,
    geoLocation,
    name,
    description,
    url,
    type,
    photoPath,
    minScale,
    lastModified,
    gallery,
    this.services,
    this.categories,
  }) : super(
          id: id,
          geoLocation: geoLocation,
          name: name,
          description: description,
          url: url,
          type: type,
          photoPath: photoPath,
          minScale: minScale,
          lastModified: lastModified,
          gallery: gallery,
        );
}
