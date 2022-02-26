import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:json_annotation/json_annotation.dart';
part 'author.g.dart';

@JsonSerializable()
class Author {
  String role;
  String name;

  Author(this.role, this.name);

  factory Author.fromJson(Map<String, dynamic> json) => _$AuthorFromJson(json);
  Map<String, dynamic> toJson() => _$AuthorToJson(this);
}




// Future<List> readAutorsFromJson() async {
//   List<Autor> autors;
//   final String response = await rootBundle.loadString('assets/sample.json');
//   final data = await json.decode(response);

//   return autors;
// }
