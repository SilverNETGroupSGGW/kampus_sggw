import 'package:kampus_sggw/models/service.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:kampus_sggw/models/types/service_types/service_types.dart';
part 'category.g.dart';

@JsonSerializable()
class Category {
  String name;
  String url;
  String description;
  List<Service> services;
  List<Category> subCategories;

  Category({
    this.name,
    this.url,
    this.description,
    this.services,
    this.subCategories,
  });

  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);

  void addData(List<String> wordsForComparisonWithSearchQuery) {
    if (_subCatExist()) {
      for (var faculties in subCategories) {
        faculties._addInnerData(wordsForComparisonWithSearchQuery);
        if (faculties._subCatExist()) {
          for (var subCat in faculties.subCategories) {
            if (subCat._subCatExist()) {
              for (var departments in subCat.subCategories) {
                departments._addInnerData(wordsForComparisonWithSearchQuery);
              }
            }
          }
        }
      }
    }
  }

  void setTypesForServices(ServiceTypes serviceTypes) {
    _setTypeForEachService(serviceTypes);
    _setTypesForServicesInSubCategories(serviceTypes);
  }

  void _setTypesForServicesInSubCategories(ServiceTypes serviceTypes) {
    if (_subCatExist()) {
      _setTypesForServicesInEachSubCategory(serviceTypes);
    }
  }

  void _setTypesForServicesInEachSubCategory(ServiceTypes serviceTypes) {
    for (var subCategory in subCategories) {
      subCategory._setTypeForEachService(serviceTypes);
      subCategory._setTypesForServicesInSubCategories(serviceTypes);
    }
  }

  void _setTypeForEachService(ServiceTypes serviceTypes) {
    if (services != null) {
      for (var service in services) {
        service.setType(serviceTypes);
      }
    }
  }

  void _addInnerData(List<String> strings) {
    strings.add(name);
    if (description != null) {
      strings.add(description);
    }
  }

  bool _subCatExist() => subCategories != null && subCategories.isNotEmpty;
}
