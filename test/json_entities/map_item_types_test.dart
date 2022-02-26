import 'package:kampus_sggw/json_entities/map_item_types.dart';
import 'package:test/test.dart';

void main() {
  group('jsonMapItemTypes', () {
    MapItemTypes mapItemTypes = new MapItemTypes(mapItemTypes: []);

    String jsonString = """{
    "mapItemTypes": [
        {
            "name": "facultyBuilding",
            "pinIconPath": "facultyMarker.png",
            "materialIconName": "school outlined",
            "functionGroup": "study"
        },
        {
            "name": "administrationBuilding",
            "pinIconPath": "administrationMarker.png",
            "materialIconName": "corporate fare outlined",
            "functionGroup": "study"
        }
      ]
    }""";

    Future<void> setUpFunc() async {
      mapItemTypes = await MapItemTypes.loadFromJson(jsonString);
    }

    setUpAll(setUpFunc);

    test('Checking the correctness of object and json 1', () {
      expect(mapItemTypes.mapItemTypes[0].name, "facultyBuilding");
    });

    test('Checking the correctness of object and json 2', () {
      expect(
          mapItemTypes.mapItemTypes[1].pinIconPath, "administrationMarker.png");
    });
  });
}
