import 'package:flutter/material.dart';
import 'package:kampus_sggw/logic/filter_service.dart';
import 'package:kampus_sggw/logic/stream_service.dart';
import 'package:kampus_sggw/models/map_item.dart';
import 'package:kampus_sggw/models/service.dart';
import '../filter_button.dart';

class FilterButtonsRow extends StatelessWidget {
  final StreamService filterButtonNotifier;

  const FilterButtonsRow({
    Key key,
    @required this.filterButtonNotifier,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: EdgeInsets.only(
          bottom: 15,
          top: 1,
          right: 10,
        ),
        child: Row(
          children: <Widget>[
            FilterButton(
              color: Colors.yellow[700],
              icon: Icons.restaurant,
              onTapFunction: () {
                filterButtonNotifier.addEvent(
                  FilterService(
                    mapItemType: MapItemType.food,
                    serviceType: ServiceType.canteen,
                  ),
                );
              },
            ),
            FilterButton(
              color: Colors.blue,
              icon: Icons.bus_alert,
              onTapFunction: () {
                filterButtonNotifier.addEvent(
                  FilterService(
                    mapItemType: MapItemType.transport,
                  ),
                );
              },
            ),
            FilterButton(
              color: Colors.orange,
              icon: Icons.local_parking,
              onTapFunction: () {
                filterButtonNotifier.addEvent(
                  FilterService(
                    mapItemType: MapItemType.parking,
                  ),
                );
              },
            ),
            FilterButton(
              color: Colors.green,
              icon: Icons.park,
              onTapFunction: () {
                filterButtonNotifier.addEvent(
                  FilterService(
                    mapItemType: MapItemType.monument,
                  ),
                );
              },
            ),
            FilterButton(
              color: Colors.red[300],
              icon: Icons.local_grocery_store,
              onTapFunction: () {
                filterButtonNotifier.addEvent(
                  FilterService(
                    mapItemType: MapItemType.store,
                    serviceType: ServiceType.vendingMachine,
                  ),
                );
              },
            ),
            FilterButton(
              color: Colors.indigo,
              icon: Icons.print_rounded,
              onTapFunction: () {
                filterButtonNotifier.addEvent(
                  FilterService(
                    serviceType: ServiceType.xero,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
