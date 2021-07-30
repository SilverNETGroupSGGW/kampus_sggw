import 'package:flutter/material.dart';
import 'package:kampus_sggw/logic/event_parameters/filter_by_function_event_param.dart';
import 'package:kampus_sggw/logic/search_services/fiter_service.dart';
import 'package:kampus_sggw/models/map_item.dart';
import 'package:kampus_sggw/models/service.dart';
import 'package:kampus_sggw/screens/map_screen/filter_button.dart';
import 'package:kampus_sggw/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';

class FilterButtons extends StatelessWidget {
  //void _onTapFunc(FilterService service, String filterName,
  //{mapItemTypes, serviceTypes}) {}
  @override
  Widget build(BuildContext context) {
    FilterService filterService =
        Provider.of<FilterService>(context, listen: false);
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
              color: Color(0xFFf29900),
              icon: Icons.restaurant,
              onTapFunction: () => filterService.filterMapItems(
                FilterByFunctionEventParam(
                  filterName: LocaleKeys.food.tr(),
                  mapItemTypes: [MapItemType.food],
                  serviceTypes: [ServiceType.canteen],
                ),
              ),
            ),
            FilterButton(
              color: Color(0xFF1a73e8),
              icon: Icons.directions_bus_outlined,
              onTapFunction: () => filterService.filterMapItems(
                FilterByFunctionEventParam(
                  filterName: LocaleKeys.bus.tr(),
                  mapItemTypes: [MapItemType.transport],
                ),
              ),
            ),
            FilterButton(
              color: Color(0xFF7986CB),
              icon: Icons.local_parking_outlined,
              onTapFunction: () => filterService.filterMapItems(
                FilterByFunctionEventParam(
                  filterName: LocaleKeys.parking.tr(),
                  mapItemTypes: [MapItemType.parking],
                ),
              ),
            ),
            FilterButton(
              color: Colors.green,
              icon: Icons.park,
              onTapFunction: () => filterService.filterMapItems(
                FilterByFunctionEventParam(
                  filterName: LocaleKeys.park.tr(),
                  mapItemTypes: [MapItemType.monument],
                ),
              ),
            ),
            FilterButton(
              color: Color(0xFF5491f5),
              icon: Icons.storefront_outlined,
              onTapFunction: () => filterService.filterMapItems(
                FilterByFunctionEventParam(
                  filterName: LocaleKeys.store.tr(),
                  mapItemTypes: [MapItemType.store, MapItemType.medicine],
                  serviceTypes: [ServiceType.vendingMachine],
                ),
              ),
            ),
            FilterButton(
              color: Colors.indigo,
              icon: Icons.print_rounded,
              onTapFunction: () => filterService.filterMapItems(
                FilterByFunctionEventParam(
                  filterName: LocaleKeys.copier.tr(),
                  serviceTypes: [ServiceType.copier],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
