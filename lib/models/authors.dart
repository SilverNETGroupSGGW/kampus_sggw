import 'package:flutter/services.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:kampus_sggw/models/author.dart';
part 'authors.g.dart';

@JsonSerializable()
class Authors {
  String? name;
  String? lang;
  List<Author>? authorsList;
  Authors(
    this.name,
    this.lang,
    this.authorsList,
  );
  factory Authors.fromJson(Map<String, dynamic> json) {
    return _$AuthorsFromJson(json);
  }

  static Future<String> getJsonSting(String lang) {
    return rootBundle.loadString('assets/json/campus_authors_' + lang + '.json');
  }
}
