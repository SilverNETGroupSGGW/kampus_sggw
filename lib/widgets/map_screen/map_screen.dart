import 'package:flutter/material.dart';
import 'package:kampus_sggw/models/building.dart';
import 'info_card.dart';
import 'interactive_map.dart';

class MapScreen extends StatefulWidget {
  final List<Building> buildings = [
    Building(
      lat: 52.16010,
      lon: 21.04476,
      name: "Budynek 32",
      departments: [
        'Wydział Nauk o Żywności',
        'Wydział Nauk o Żywieniu Człowieka i Konsumpcji',
      ],
    ),
    Building(
      lat: 52.16203,
      lon: 21.04632,
      name: "Budynek 34",
      departments: [
        'Wydział Leśny',
        'Wydział Technologii Drewna',
        'Wydział Zastosowań Matematyki i Informatyki',
      ],
    ),
    Building(
      lat: 52.16191,
      lon: 21.04293,
      name: "Budynek 37",
      departments: [
        'Wydział Ogrodnictwa, Biotechnologii i Architektury Krajobrazu',
        'Wydział Rolnictwa i Biologii'
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