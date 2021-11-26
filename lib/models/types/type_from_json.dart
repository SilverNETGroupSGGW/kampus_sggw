import 'package:kampus_sggw/models/map_object_application.dart';

abstract class TypeFromJSON {
  String name;
  int materialIconID;
  MapObjectApplication objectApplication;

  TypeFromJSON({
    this.name,
    this.materialIconID,
    this.objectApplication,
  });

  // void _setIcon() {
  //   materialIcon = Icon(IconData(materialIconID, fontFamily: 'MaterialIcons'));
  // }
}
