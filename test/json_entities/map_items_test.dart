import 'package:kampus_sggw/json_entities/map_items.dart';
import 'package:test/test.dart';

void main() {
  group('jsonEntities', () {
    MapItems mapItems = new MapItems(mapItems: []);

    String jsonString = """{
    "mapItems": [
        {
            "id": "34",
            "geoLocation": {
                "lat": 52.16200,
                "lon": 21.04634
            },
            "name": "Budynek 34",
            "description": "Budynek WZIM, WL, WTD",
            "type": "facultyBuilding",
            "buildingService": [
                {
                    "id": "1c5fa7f2-9935-4801-83a1-7c2a142bff4a",
                    "name": "Drukarnia/ksero",
                    "description": "Ksero samoobsługowe, położone na poziomie -1",
                    "type": "copier"
                },
                {
                    "id": "1c5fa7f2-9935-4801-83a1-7c2a142bff4a",
                    "name": "Bufet",
                    "description": "Kartka",
                    "type": "canteen"
                }
            ],
            "faculties": [
                {
                    "id": "45aa620b-c951-4364-9ea3-6ccee864a094",
                    "name": "WZIM",
                    "description": "Wydział Zastosowań Informatyki i Matematyki",
                    "url": "http://wzim.sggw.pl/",
                    "facultyServices": [
                        {
                          "id": "45aa620b-c951-4364-9ea3-6ccee864a094",
                            "name": "Dziekanat WZIM",
                            "type": "deanery",
                            "description": "Pokój 3/35 i 3/36B",
                            "url": "http://student.wzim.sggw.pl/"
                        }
                    ]
                },
                {
                  "id": "45aa620b-c951-4364-9ea3-6ccee864a094",
                    "name": "WL",
                    "description": "Wydział Leśny",
                    "url": "http://wl.sggw.pl/",
                    "facultyServices": [
                        {
                          "id": "45aa620b-c951-4364-9ea3-6ccee864a094",
                            "name": "Dziekanat WL",
                            "type": "deanery",
                            "description": "Pokój 0/7, 0/8 i 0/9",
                            "url": "http://wl.sggw.pl/dziekanat"
                        }
                    ]
                },
                {
                  "id": "45aa620b-c951-4364-9ea3-6ccee864a094",
                    "name": "WTD",
                    "description": "Wydział Technologii Drewna",
                    "url": "http://wtd.sggw.pl/",
                    "facultyServices": [
                        {
                          "id": "45aa620b-c951-4364-9ea3-6ccee864a094",
                            "name": "Dziekanat WTD",
                            "type": "deanery",
                            "description": "Pokój 1/19 i 1/20",
                            "url": "http://wtd.sggw.pl/Content/dziekana"
                        }
                    ]
                }
            ],
            "institutes": [
                {
                    "id": "1c0778f6-c289-49da-befe-521ef8318a3b",
                    "name": "IIT",
                    "description": "Instytut Informatyki Technicznej",
                    "url": "https://www.iit.sggw.pl/",
                    "departments": [
                        {
                          "id": "1c454hdsf6-c289-49da-befe-521ef8318a3b",
                            "name": "Katedra Systemów Informatycznych"
                        },
                        {
                          "id": "1c454hdsf6-c289-49da-befe-521ef8318a3b",
                            "name": "Katedra Sztucznej Inteligencji"
                        },
                        {
                          "id": "1c454hdsf6-c289-49da-befe-521ef8318a3b",
                            "name": "Katedra Zastosowań Matematyki"
                        },
                        {
                          "id": "1c454hdsf6-c289-49da-befe-521ef8318a3b",
                            "name": "Laboratorium Komputerowe"
                        }
                    ]
                },
                {
                    "id": "1c454hdsf6-c289-49da-befe-521ef8318a3b",
                    "name": "IEiF",
                    "description": "Instytut Ekonomii i Finansów",
                    "url": "https://www.ieif.sggw.pl/",
                    "departments": [
                        {
                          "id": "1c454hdsf6-c289-49da-befe-521ef8318a3b",
                            "name": "Katedra Ekonometrii i Statystyki"
                        }
                    ]
                },
                {
                    "id": "1c452f6-c289-49da-befe-521ef8318a3b",
                    "name": "INL",
                    "description": "Instytut Nauk Leśnych",
                    "url": "http://wl.sggw.pl/science"
                }
            ]
        }
    ]
  }""";

    Future<void> setUpFunc() async {
      mapItems = await MapItems.loadFromJson(jsonString);
    }

    setUpAll(setUpFunc);

    test('First faculty should be read from test json', () {
      expect(mapItems.mapItems[0].faculties[0].name, 'WZIM');
    });
    test('WL should from test json should have deanery', () {
      expect(mapItems.mapItems[0].faculties[1].facultyServices[0].name,
          'Dziekanat WL');
    });
  });
}
