import 'package:kampus_sggw/models/service.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:kampus_sggw/models/types/service_types/service_types.dart';
part 'category.g.dart';

@JsonSerializable()
class Category {
  String? name;
  String? url;
  String? description;
  @JsonKey(defaultValue: <Service>[])
  List<Service>? services;
  @JsonKey(defaultValue: <Category>[])
  List<Category>? subCategories;

  Category({
    this.name,
    this.url,
    this.description,
    this.services,
    this.subCategories,
  });

  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);

  Set<String?> getWordsForComparisonWithSearchQuery() {
    Set<String?> words = {};
    for (var faculty in subCategories!) {
      words = faculty._getWordsFromInnerCategory();
      for (var subCategory in faculty.subCategories!) {
        for (var department in subCategory.subCategories!) {
          words.addAll(department._getWordsFromInnerCategory());
        }
      }
    }
    return words;
  }

  void setTypesForServices(ServiceTypes serviceTypes) {
    _setTypeForEachService(serviceTypes);
    _setTypesForServicesInSubCategories(serviceTypes);
  }

  void _setTypesForServicesInSubCategories(ServiceTypes serviceTypes) {
    for (var subCategory in subCategories!) {
      subCategory._setTypeForEachService(serviceTypes);
      subCategory._setTypesForServicesInSubCategories(serviceTypes);
    }
  }

  void _setTypeForEachService(ServiceTypes serviceTypes) =>
      services!.forEach((service) => service.setType(serviceTypes));

  Set<String?> _getWordsFromInnerCategory() =>
      _getInnerWords().union(_getWordsForComparisonFromServices());

  Set<String?> _getWordsForComparisonFromServices() {
    Set<String?> words = {};
    services!.forEach(
        (service) => words.addAll(service.wordsToCompareWithSearchQuery));
    return words;
  }

  Set<String?> _getInnerWords() => {name, description};
}
