import 'package:flutter/services.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:kampus_sggw/models/autor.dart';
part 'autors.g.dart';

@JsonSerializable()
class Autors {
  String? name;
  String? lang;
  List<Autor>? autorsList;
  Autors(
    this.name,
    this.lang,
    this.autorsList,
  );
  factory Autors.fromJson(Map<String, dynamic> json) {
    return _$AutorsFromJson(json);
  }
  void readAutors() {
    print(name);
    for (Autor autor in autorsList!) {
      print(1);
      print(autor.name);
    }
  }

  static Future<String> getJsonSting() {
    return rootBundle.loadString('assets/json/campus_autors.json');
  }
}
