import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class Autor {
  String role;
  String name;

  Autor(this.role, this.name);

  Autor.fromJson(Map<String, dynamic> json)
      : role = json['role'],
        name = json['name'];
}




// Future<List> readAutorsFromJson() async {
//   List<Autor> autors;
//   final String response = await rootBundle.loadString('assets/sample.json');
//   final data = await json.decode(response);

//   return autors;
// }
