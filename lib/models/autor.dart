import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:json_annotation/json_annotation.dart';
part 'autor.g.dart';

@JsonSerializable()
class Autor {
  String role;
  String name;

  Autor(this.role, this.name);

  factory Autor.fromJson(Map<String, dynamic> json) => _$AutorFromJson(json);
  Map<String, dynamic> toJson() => _$AutorToJson(this);
}




// Future<List> readAutorsFromJson() async {
//   List<Autor> autors;
//   final String response = await rootBundle.loadString('assets/sample.json');
//   final data = await json.decode(response);

//   return autors;
// }
