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
