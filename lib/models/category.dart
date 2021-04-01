import 'service.dart';

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
}
