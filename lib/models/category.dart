import 'package:kampus_sggw/models/service.dart';
import 'package:json_annotation/json_annotation.dart';
part 'category.g.dart';

@JsonSerializable()
class Category {
  String name;
  String url;
  String description;
  List<Service> services;
  List<Category> subCategories;
  Category(
    this.name,
    this.url,
    this.description,
    this.services,
    this.subCategories,
  );
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

  void _addInnerData(List<String> strings) {
    strings.add(name);
    if (description != null) {
      strings.add(description);
    }
  }

  bool _subCatExist() =>
      subCategories != null && subCategories.isNotEmpty ? true : false;
}
