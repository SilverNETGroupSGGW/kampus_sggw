import 'package:fuzzy/fuzzy.dart';
import 'package:kampus_sggw/models/category.dart';
import 'package:kampus_sggw/models/location.dart';
import 'package:kampus_sggw/models/service.dart';
import 'package:json_annotation/json_annotation.dart';
part 'map_item.g.dart';

enum MapItemType {
  facultyBuilding,
  administrationBuilding,
  sportsFacility,
  store,
  food,
  library,
  parking,
  transport,
  finance,
  dormitories,
  kindergarten,
  monument,
  medicine,
}

@JsonSerializable()
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
  List<Service> services;
  List<Category> categories;
  @JsonKey(ignore: true)
  Fuzzy searchingSet;

  MapItem(
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
    this.services,
    this.categories,
  );
  factory MapItem.fromJson(Map<String, dynamic> json) =>
      _$MapItemFromJson(json);

  bool containsAtLeastOneServiceType(List<ServiceType> serviceTypes) {
    return services == null
        ? false
        : services.any((service) => serviceTypes.contains(service.type));
  }

  void generateFuzzySet() {
    List<String> strings = [];
    _addData(strings);
    searchingSet = _getFuse(strings);
  }

  void _addInnerData(List<String> strings) {
    strings.add(name);
    if (description != null) {
      strings.add(description);
    }
  }

  bool _categoriesExist() =>
      categories != null && categories.isNotEmpty ? true : false;

  void _addData(List<String> strings) {
    _addInnerData(strings);
    if (_categoriesExist()) {
      for (var cat in categories) {
        cat.addData(strings);
      }
    }
  }

  Fuzzy _getFuse(List<String> strings) {
    return Fuzzy(
      strings,
      options: FuzzyOptions(
        findAllMatches: true,
        tokenize: true,
        threshold: 0.5,
      ),
    );
  }
}
