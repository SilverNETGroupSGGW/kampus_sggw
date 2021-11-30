import 'package:flutter/material.dart';
import 'package:kampus_sggw/logic/event_parameters/filtration_event_param.dart';
import 'package:kampus_sggw/logic/search_services/filter_service.dart';
import 'package:kampus_sggw/logic/object_function_group.dart';
import 'package:kampus_sggw/screens/map_screen/filter_button.dart';
import 'package:kampus_sggw/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';

class FilterButtons extends StatelessWidget {
  final FilterService filterService;

  const FilterButtons({
    Key? key,
    required this.filterService,
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
            _filterButton(
              Color(0xFFf29900),
              Icons.restaurant,
              LocaleKeys.food.tr(),
              ObjectFunctionGroup.food,
            ),
            _filterButton(
              Color(0xFF1a73e8),
              Icons.directions_bus_outlined,
              LocaleKeys.bus.tr(),
              ObjectFunctionGroup.transport,
            ),
            _filterButton(
              Color(0xFF7986CB),
              Icons.local_parking_outlined,
              LocaleKeys.parking.tr(),
              ObjectFunctionGroup.parking,
            ),
            _filterButton(
              Colors.green,
              Icons.park,
              LocaleKeys.park.tr(),
              ObjectFunctionGroup.park,
            ),
            _filterButton(
              Color(0xFF5491f5),
              Icons.storefront_outlined,
              LocaleKeys.store.tr(),
              ObjectFunctionGroup.store,
            ),
            _filterButton(
              Colors.indigo,
              Icons.print_rounded,
              LocaleKeys.copier.tr(),
              ObjectFunctionGroup.copier,
            ),
          ],
        ),
      ),
    );
  }

  FilterButton _filterButton(
    Color color,
    IconData iconData,
    String filterName,
    ObjectFunctionGroup functionGroup,
  ) {
    return FilterButton(
      color: color,
      iconData: iconData,
      onTapFunction: () => filterService.filterMapItems(
        FiltrationEventParam(
          filterName: filterName,
          functionGroup: functionGroup,
        ),
      ),
    );
  }
}
