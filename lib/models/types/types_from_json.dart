import 'package:kampus_sggw/models/types/type_from_json.dart';

abstract class TypesFromJson {
  List<TypeFromJson> types;
  TypesFromJson({
    this.types,
  });

  TypeFromJson getTypeByName(String typeName) =>
      types.firstWhere((type) => type.name == typeName);
}
