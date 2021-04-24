import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:kampus_sggw/models/category.dart';
import 'package:kampus_sggw/models/location.dart';
import 'package:kampus_sggw/models/building.dart';
import 'package:kampus_sggw/global_widgets/side_drawer.dart';
import 'package:kampus_sggw/models/map_item.dart';
import 'package:kampus_sggw/models/service.dart';
import 'package:kampus_sggw/translations/locale_keys.g.dart';
import 'info_card.dart';
import 'interactive_map.dart';
import 'map_floating_buttons.dart';

class MapScreen extends StatefulWidget {
  final List<Building> buildings = [
    Building(
      1,
      Location(52.16010, 21.04476),
      "Budynek 32",
      null,
      null,
      MapItemType.facultyBuilding,
      "assets/images/map_objects/wzim.jpg",
      1.0,
      new DateTime(2020, 04, 01, 08, 38),
      null,
      null,
      [
        Category(
          'Faculties',
          null,
          null,
          null,
          [
            Category(
              'Wydział Nauk o Żywności',
              null,
              null,
              null,
              null,
            ),
            Category(
              'Wydział Nauk o Żywieniu Człowieka i Konsumpcji',
              null,
              null,
              null,
              null,
            ),
          ],
        ),
      ],
    ),
    Building(
      2,
      Location(52.16203, 21.04632),
      "Budynek 34",
      null,
      null,
      MapItemType.facultyBuilding,
      "assets/images/map_objects/wzim.jpg",
      1.0,
      new DateTime(2020, 04, 01, 08, 38),
      null,
      [
        new Service(
          'xero',
          ServiceType.xero,
          'Xero na 1 piętrze',
          null,
          null,
        ),
        new Service(
          'Kartka',
          ServiceType.canteen,
          'Bufet w piwnicy. Można tam nawet dobrze zjeść. Wyśmienite pierogi mmm...',
          null,
          null,
        ),
      ],
      [
        Category(
          'Faculties',
          null,
          null,
          null,
          [
            Category(
              'Wydział Leśny',
              null,
              null,
              null,
              null,
            ),
            Category(
              'Wydział Technologii Drewna',
              null,
              null,
              null,
              null,
            ),
            Category(
              'Wydział Zastosowań Matematyki i Informatyki',
              null,
              null,
              null,
              null,
            ),
          ],
        ),
      ],
    ),
    // Building(
    //   geoLocation: Location(lat: 52.16191, lon: 21.04293),
    //   name: "Budynek 37",
    //   photoPath: "assets/images/map_objects/wzim.jpg",
    //   categories: [
    //     Category(
    //       name: 'Faculties',
    //       subCategories: [
    //         Category(
    //           name:
    //               'Wydział Ogrodnictwa, Biotechnologii i Architektury Krajobrazu',
    //         ),
    //         Category(
    //           name: 'Wydział Rolnictwa i Biologii',
    //         ),
    //       ],
    //     ),
    //   ],
    // ),
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
        title: Text(LocaleKeys.map_screen_title.tr()),
      ),
      body: Stack(
        children: [
          InteractiveMap(
            widget.buildings,
            showInfoCard,
          ),
        ],
      ),
      floatingActionButton: MapFloatingButtons(),
      drawer: SideDrawer(),
    );
  }
}
