import 'package:kampus_sggw/json_entities/map_item_types.dart';
import 'package:kampus_sggw/json_entities/service_types.dart';
import 'package:test/test.dart';

void main() {
  group('jsonServiceTypes', () {
    ServiceTypes serviceTypes = new ServiceTypes(serviceTypes: []);

    String jsonString = """{
    "serviceTypes": [
        {
            "name": "copier",
            "materialIconName": "print rounded",
            "color": "0xFF3F51B5"
        },
        {
            "name": "canteen",
            "materialIconName": "restaurant",
            "color": "0xFFFBC02D"
        }
      ]
    }""";

    Future<void> setUpFunc() async {
      serviceTypes = await ServiceTypes.loadFromJson(jsonString);
    }

    setUpAll(setUpFunc);

    test('Checking the correctness of object and json 1', () {
      expect(serviceTypes.serviceTypes[0].name, "copier");
    });

    test('Checking the correctness of object and json 2', () {
      expect(serviceTypes.serviceTypes[1].color, "0xFFFBC02D");
    });
  });
}
