import 'package:kampus_sggw/models/category.dart';
import 'package:kampus_sggw/models/location.dart';

import 'package:flutter/material.dart';
import 'package:kampus_sggw/models/building.dart';
import 'package:kampus_sggw/screens/map_screen/location_pin.dart';
import 'info_card.dart';
import 'interactive_map.dart';

class MapScreen extends StatefulWidget {
  final List<Building> buildings = [
    Building(
      geoLocation: Location(lat: 52.16010, lon: 21.04476),
      name: "Budynek 32",
      categories: [
        Category(name: 'Faculties', subCategories: [
          Category(name: 'Wydział Nauk o Żywności'),
          Category(name: 'Wydział Nauk o Żywieniu Człowieka i Konsumpcji')
        ])
      ],
    ),
    Building(
      geoLocation: Location(lat: 52.16203, lon: 21.04632),
      name: "Budynek 34",
      categories: [
        Category(name: 'Faculties', subCategories: [
          Category(name: 'Wydział Leśny'),
          Category(name: 'Wydział Technologii Drewna'),
          Category(name: 'Wydział Zastosowań Matematyki i Informatyki'),
        ])
      ],
    ),
    Building(
      geoLocation: Location(lat: 52.16191, lon: 21.04293),
      name: "Budynek 37",
      categories: [
        Category(name: 'Faculties', subCategories: [
          Category(
              name:
                  'Wydział Ogrodnictwa, Biotechnologii i Architektury Krajobrazu'),
          Category(name: 'Wydział Rolnictwa i Biologii')
        ])
      ],
    ),
  ];

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  static Building _selectedBuilding;

  showInfoCard(Building building) {
    _selectedBuilding = building;
    Navigator.of(context).restorablePush(_dialogBuilder);
  }

  static Route<Object> _dialogBuilder(BuildContext context, Object arguments) {
    return DialogRoute<void>(
      context: context,
      builder: (BuildContext context) =>
          InfoCardDialog.fromBuilding(_selectedBuilding),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Kampus SGGW"),
      ),
      body: Stack(children: [
        InteractiveMap(
          widget.buildings,
          showInfoCard,
        ),
      ]),
    );
  }
}
