import 'package:kampus_sggw/models/building.dart';
import 'package:kampus_sggw/models/category.dart';
import 'package:kampus_sggw/models/location.dart';
import 'package:kampus_sggw/models/map_item_type.dart';
import 'package:kampus_sggw/models/service.dart';

var building34 = new Building(
  id: 34,
  name: 'Building 34',
  geoLocation: new Location(lat: 52.174, lon: 54.96),
  description: 'Budynek WZIM, WL i WTD',
  url: 'http://www.sggw.pl/',
  type: MapItemType.facultyBuilding,
  photoPath: 'assets/buildings/34',
  minScale: 0.54,
  lastModified: new DateTime(2020, 04, 01, 08, 38),
  gallery: null,
  services: [
    new Service(
        name: 'xero', type: ServiceType.xero, description: 'Xero na 1 piętrze'),
    new Service(
        name: 'Kartka',
        type: ServiceType.canteen,
        description: 'Bufet w piwnicy'),
  ],
  categories: [
    new Category(
      name: 'Faculties',
      subCategories: [
        new Category(
          name: 'Wydział Zastosowań Informatyki i Matematyki',
          url: 'http://www.wzim.sggw.pl/',
          description:
              '2 piętro, Kierunki: Informatyka, Informatyka i Ekonometria',
          services: [
            new Service(name: 'Dziekanat WZIM', type: ServiceType.deanery),
            new Service(
                name: 'Automat z kawą', type: ServiceType.vendingMachine),
            new Service(name: 'Aula III', type: ServiceType.lectureHall),
            new Service(name: 'Aula IV', type: ServiceType.lectureHall),
          ],
          subCategories: [
            new Category(
              name: 'Departments',
              subCategories: [
                new Category(name: 'Katedra Zastosowań Informatyki'),
                new Category(name: 'Katedra Informatyki'),
                new Category(name: 'Katedra Ekonometrii i Statystyki'),
                new Category(name: 'Katedra Zastosowań Matematyki'),
              ],
            ),
          ],
        ),
        new Category(
          name: 'Wydział leśny',
          url: 'http://wl.sggw.pl/news',
          description: '1 piętro, Kierunki: Leśnictwo',
          services: [
            new Service(name: 'Dziekanat WL', type: ServiceType.deanery),
          ],
          subCategories: [
            new Category(
              name: 'Departments',
              subCategories: [
                new Category(name: 'Instytut Nauk Leśnych'),
              ],
            ),
          ],
        ),
        new Category(
          name: 'Wydział technologii drewna',
          services: [
            new Service(name: 'Dziekanat WTD', type: ServiceType.deanery),
          ],
        ),
      ],
    ),
  ],
);
