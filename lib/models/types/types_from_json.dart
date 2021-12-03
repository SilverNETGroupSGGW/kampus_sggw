import 'dart:collection';

import 'package:json_annotation/json_annotation.dart';
import 'package:kampus_sggw/models/types/type_from_json.dart';

@JsonSerializable()
abstract class TypesFromJson {
  List<TypeFromJson>? typesFromJson;
  @JsonKey(ignore: true)
  Map<String?, TypeFromJson> _types = new Map<String?, TypeFromJson>();

  TypesFromJson({
    this.typesFromJson,
  }) {
    _mapTypes();
  }

  UnmodifiableMapView<String?, TypeFromJson> get types =>
      UnmodifiableMapView(_types);

  void _mapTypes() =>
      typesFromJson!.forEach((type) => _types[type.name] = type);
}
