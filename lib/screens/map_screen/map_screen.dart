import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kampus_sggw/global_widgets/side_drawer.dart';
import 'package:kampus_sggw/logic/histories/visit_history.dart';
import 'package:kampus_sggw/logic/search_services/markers_service.dart';
import 'package:kampus_sggw/logic/info_card_dialog_builder.dart';
import 'package:kampus_sggw/models/map_item.dart';
import 'package:kampus_sggw/models/map_items.dart';
import 'package:kampus_sggw/screens/map_screen/interactive_map.dart';
import 'package:kampus_sggw/screens/map_screen/map_buttons.dart';
import 'package:kampus_sggw/screens/map_screen/map_markers.dart';
import 'package:kampus_sggw/screens/map_screen/marker_type_enum.dart';
import 'package:kampus_sggw/screens/map_screen/search_button.dart';
import 'package:kampus_sggw/screens/map_screen/search_widgets/search_bar.dart';
import 'package:kampus_sggw/translations/locale_keys.g.dart';
import 'package:provider/provider.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  static MapItem _selectedMapItem;
  MapMarkers _markersProvider;
  SearchButton _searchButton;

  void showCardFunc(MapItem mapItem) {
    _selectedMapItem = mapItem;
    Provider.of<VisitHistory>(context, listen: false).addItem(mapItem);
    Navigator.of(context).restorablePush(_dialogBuilder);
  }

  static Route<Object> _dialogBuilder(BuildContext context, Object arguments) {
    return DialogRoute<void>(
      context: context,
      builder: (BuildContext context) =>
          InfoCardDialogBuilder().fromMapItem(_selectedMapItem),
    );
  }

  void _showBottomDrawer() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.8,
        child: SearchBar(),
      ),
    );
  }

  // void _asyncFunc() async {
  //   _markersProvider.addBitmapDescriptor(
  //     MarkerTypeEnum.facultyMarker,
  //     await BitmapDescriptor.fromAssetImage(
  //         ImageConfiguration(size: Size(30, 45)),
  //         'assets/images/icons/facultyMarker.png'),
  //   );

  //   _markersProvider.addBitmapDescriptor(
  //     MarkerTypeEnum.sportMarker,
  //     await BitmapDescriptor.fromAssetImage(
  //         ImageConfiguration(size: Size(30, 45)),
  //         'assets/images/icons/sportMarker.png'),
  //   );

  //   _markersProvider.addBitmapDescriptor(
  //     MarkerTypeEnum.administrationMarker,
  //     await BitmapDescriptor.fromAssetImage(
  //         ImageConfiguration(size: Size(30, 45)),
  //         'assets/images/icons/administrationMarker.png'),
  //   );

  //   _markersProvider.addBitmapDescriptor(
  //     MarkerTypeEnum.hotelMarker,
  //     await BitmapDescriptor.fromAssetImage(
  //         ImageConfiguration(size: Size(30, 45)),
  //         'assets/images/icons/hotelMarker.png'),
  //   );

  //   _markersProvider.addBitmapDescriptor(
  //     MarkerTypeEnum.storeMarker,
  //     await BitmapDescriptor.fromAssetImage(
  //         ImageConfiguration(size: Size(30, 45)),
  //         'assets/images/icons/storeMarker.png'),
  //   );

  //   _markersProvider.addBitmapDescriptor(
  //     MarkerTypeEnum.foodMarker,
  //     await BitmapDescriptor.fromAssetImage(
  //         ImageConfiguration(size: Size(30, 45)),
  //         'assets/images/icons/foodMarker.png'),
  //   );

  //   _markersProvider.addBitmapDescriptor(
  //     MarkerTypeEnum.libraryMarker,
  //     await BitmapDescriptor.fromAssetImage(
  //         ImageConfiguration(size: Size(30, 45)),
  //         'assets/images/icons/libraryMarker.png'),
  //   );

  //   _markersProvider.addBitmapDescriptor(
  //     MarkerTypeEnum.parkingMarker,
  //     await BitmapDescriptor.fromAssetImage(
  //         ImageConfiguration(size: Size(30, 45)),
  //         'assets/images/icons/parkingMarker.png'),
  //   );

  //   _markersProvider.addBitmapDescriptor(
  //     MarkerTypeEnum.transportMarker,
  //     await BitmapDescriptor.fromAssetImage(
  //         ImageConfiguration(size: Size(30, 45)),
  //         'assets/images/icons/transportMarker.png'),
  //   );

  //   _markersProvider.addBitmapDescriptor(
  //     MarkerTypeEnum.financeMarker,
  //     await BitmapDescriptor.fromAssetImage(
  //         ImageConfiguration(size: Size(30, 45)),
  //         'assets/images/icons/financeMarker.png'),
  //   );
  //   print("waited");

  //   _markersProvider.addBitmapDescriptor(
  //     MarkerTypeEnum.otherMarker,
  //     await BitmapDescriptor.fromAssetImage(
  //         ImageConfiguration(size: Size(30, 45)),
  //         'assets/images/icons/otherMarker.png'),
  //   );

  //   print("waited");
  // }

  @override
  void initState() {
    super.initState();
    _markersProvider = Provider.of<MapMarkers>(context, listen: false);
    //WidgetsBinding.instance.addPostFrameCallback(

    //_asyncFunc();
    //   (_) async {
    //     _markersProvider.addBitmapDescriptor(
    //       MarkerTypeEnum.facultyMarker,
    //       await BitmapDescriptor.fromAssetImage(
    //           ImageConfiguration(size: Size(30, 45)),
    //           'assets/images/icons/facultyMarker.png'),
    //     );

    //     _markersProvider.addBitmapDescriptor(
    //       MarkerTypeEnum.sportMarker,
    //       await BitmapDescriptor.fromAssetImage(
    //           ImageConfiguration(size: Size(30, 45)),
    //           'assets/images/icons/sportMarker.png'),
    //     );

    //     _markersProvider.addBitmapDescriptor(
    //       MarkerTypeEnum.administrationMarker,
    //       await BitmapDescriptor.fromAssetImage(
    //           ImageConfiguration(size: Size(30, 45)),
    //           'assets/images/icons/administrationMarker.png'),
    //     );

    //     _markersProvider.addBitmapDescriptor(
    //       MarkerTypeEnum.hotelMarker,
    //       await BitmapDescriptor.fromAssetImage(
    //           ImageConfiguration(size: Size(30, 45)),
    //           'assets/images/icons/hotelMarker.png'),
    //     );

    //     _markersProvider.addBitmapDescriptor(
    //       MarkerTypeEnum.storeMarker,
    //       await BitmapDescriptor.fromAssetImage(
    //           ImageConfiguration(size: Size(30, 45)),
    //           'assets/images/icons/storeMarker.png'),
    //     );

    //     _markersProvider.addBitmapDescriptor(
    //       MarkerTypeEnum.foodMarker,
    //       await BitmapDescriptor.fromAssetImage(
    //           ImageConfiguration(size: Size(30, 45)),
    //           'assets/images/icons/foodMarker.png'),
    //     );

    //     _markersProvider.addBitmapDescriptor(
    //       MarkerTypeEnum.libraryMarker,
    //       await BitmapDescriptor.fromAssetImage(
    //           ImageConfiguration(size: Size(30, 45)),
    //           'assets/images/icons/libraryMarker.png'),
    //     );

    //     _markersProvider.addBitmapDescriptor(
    //       MarkerTypeEnum.parkingMarker,
    //       await BitmapDescriptor.fromAssetImage(
    //           ImageConfiguration(size: Size(30, 45)),
    //           'assets/images/icons/parkingMarker.png'),
    //     );

    //     _markersProvider.addBitmapDescriptor(
    //       MarkerTypeEnum.transportMarker,
    //       await BitmapDescriptor.fromAssetImage(
    //           ImageConfiguration(size: Size(30, 45)),
    //           'assets/images/icons/transportMarker.png'),
    //     );

    //     _markersProvider.addBitmapDescriptor(
    //       MarkerTypeEnum.financeMarker,
    //       await BitmapDescriptor.fromAssetImage(
    //           ImageConfiguration(size: Size(30, 45)),
    //           'assets/images/icons/financeMarker.png'),
    //     );

    //     _markersProvider.addBitmapDescriptor(
    //       MarkerTypeEnum.otherMarker,
    //       await BitmapDescriptor.fromAssetImage(
    //           ImageConfiguration(size: Size(30, 45)),
    //           'assets/images/icons/otherMarker.png'),
    //     );
    //   },
    // );
    //setState(() {});
    print("not waited");
    _markersProvider.initializeDefaultMarkers(
      Provider.of<MapItems>(context, listen: false),
      showCardFunc,
    );
    _searchButton = SearchButton(
      _showBottomDrawer,
      Provider.of<MarkersService>(context, listen: false),
      Provider.of<MapMarkers>(context, listen: false),
      () => Navigator.pop(context),
    );
    Provider.of<MarkersService>(context, listen: false).searchButton =
        _searchButton;
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: _searchButton),
        // ChangeNotifierProvider(
        //   create: (_) => SearchButton(
        //     _showBottomDrawer,
        //     Provider.of<MapMarkers>(context, listen: false),
        //     Provider.of<MarkersService>(context, listen: false),
        //     () => Navigator.pop(context),
        //  ),
        //),
      ],
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text(
            LocaleKeys.map_screen_title.tr(),
            style: TextStyle(
              fontFamily: 'SGGWSans',
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        body: Stack(
          children: [
            InteractiveMap(
                //showCard: showInfoCard,
                ),
          ],
        ),
        floatingActionButton: MapButtons(),
        drawer: SideDrawer(),
      ),
    );
  }
}
