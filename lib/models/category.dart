import 'service.dart';
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
  factory Category.fromJson(Map<String, dynamic> json) => _$CategoryFromJson(json);
}
