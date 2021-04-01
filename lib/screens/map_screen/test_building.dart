import 'package:kampus_sggw/models/building.dart';
import 'package:kampus_sggw/models/category.dart';
import 'package:kampus_sggw/models/location.dart';
import 'package:kampus_sggw/models/map_item_type.dart';
import 'package:kampus_sggw/models/service.dart';

var building34 = new Building(
    id: 34,
    name: 'Building 34',
    geoLocation: new Location(lat: 52.174, lon: 54.96),
    description: 'WZIM, WL, ... building',
    url: 'http://www.sggw.pl/',
    type: MapItemType.facultyBuilding,
    photoPath: 'assets/buildings/34',
    minScale: 0.54,
    lastModified: new DateTime(2020, 04, 01, 08, 38),
    gallery: null,
    services: [
      new Service(
          name: 'xero',
          type: ServiceType.xero,
          description: 'xero on second floor'),
      new Service(
          name: 'Kartka',
          type: ServiceType.canteen,
          description: 'Canteen in the basement')
    ],
    categories: [
      new Category(name: 'Faculties', subCategories: [
        new Category(
            name: 'WZIM',
            url: 'http://www.wzim.sggw.pl/',
            description: 'Faculties: IT, IT and Economentrics, floor 2',
            services: [
              new Service(name: 'WZIM deanery', type: ServiceType.deanery),
            ],
            subCategories: [
              new Category(name: 'Departments', subCategories: [
                new Category(name: 'Department of AI'),
                new Category(name: 'Usage of Mathematics'),
              ]),
            ]),
        new Category(name: 'WL', services: [
          new Service(name: 'WL deanery', type: ServiceType.deanery),
        ]),
      ]),
    ]);
