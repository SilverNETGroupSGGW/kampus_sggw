import 'package:kampus_sggw/models/types/type_from_json.dart';

abstract class TypesFromJSON {
  List<TypeFromJSON> types;
  TypesFromJSON({
    this.types,
  });

  TypeFromJSON getTypeByName(String typeName) =>
      types.firstWhere((type) => type.name == typeName);
}
