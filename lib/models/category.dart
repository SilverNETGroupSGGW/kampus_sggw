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

  void addData(List<String> strings) {
    if (_subCatExist()) {
      for (var faculties in subCategories) {
        faculties._addInnerData(strings);
        if (faculties._subCatExist()) {
          for (var subCat in faculties.subCategories) {
            if (subCat._subCatExist()) {
              for (var departments in subCat.subCategories) {
                departments._addInnerData(strings);
              }
            }
          }
        }
      }
    }
  }

  void setServicesType(ServiceTypes serviceTypes) {
    _setServicesTypeFor(services, serviceTypes);
    if (_subCatExist()) {
      for (var subCategory in subCategories) {
        _setServicesTypeFor(subCategory.services, serviceTypes);
        if (subCategory._subCatExist()) {
          for (var subSubCat in subCategory.subCategories) {
            _setServicesTypeFor(subSubCat.services, serviceTypes);
            if (subSubCat._subCatExist()) {
              for (var subSubSubCat in subSubCat.subCategories) {
                _setServicesTypeFor(subSubSubCat.services, serviceTypes);
              }
            }
          }
        }
      }
    }
  }

  void _setServicesTypeFor(List<Service> services, ServiceTypes serviceTypes) {
    if (services != null) {
      print("czy pusteCat " + serviceTypes.types.isEmpty.toString());
      services.forEach((service) {
        service.setType(serviceTypes);
      });
    }
  }

  void _addInnerData(List<String> strings) {
    strings.add(name);
    if (description != null) {
      strings.add(description);
    }
  }

  bool _subCatExist() =>
      subCategories != null && subCategories.isNotEmpty ? true : false;
}
