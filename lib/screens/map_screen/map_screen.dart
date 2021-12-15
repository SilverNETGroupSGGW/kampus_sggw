import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:kampus_sggw/global_widgets/side_drawer.dart';
import 'package:kampus_sggw/logic/histories/visit_history.dart';
import 'package:kampus_sggw/logic/controllers/map_markers_controller.dart';
import 'package:kampus_sggw/logic/search_services/search_service.dart';
import 'package:kampus_sggw/logic/info_card_dialog_builder.dart';
import 'package:kampus_sggw/models/map_item.dart';
import 'package:kampus_sggw/models/map_items.dart';
import 'package:kampus_sggw/screens/map_screen/interactive_map.dart';
import 'package:kampus_sggw/screens/map_screen/map_buttons.dart';
import 'package:kampus_sggw/logic/controllers/search_button_controller.dart';
import 'package:kampus_sggw/screens/map_screen/search_widgets/search_bar.dart';
import 'package:kampus_sggw/translations/locale_keys.g.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  static late MapItem _selectedMapItem;

  @override
  void initState() {
    super.initState();
    Provider.of<MapMarkersController>(context, listen: false)
        .initializeDefaultMarkers(
      Provider.of<MapItems>(context, listen: false),
      _showCardFunc,
    );
  }

  bool _wantUserExitApplication = false;

  @override
  Widget build(BuildContext context) {
    bool drawerIsClosing = false;
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) {
          return SearchButtonController(
            searchService: Provider.of<SearchService>(context, listen: false),
            onSearchButtonPressed: _showBottomDrawer,
            collapseBottomDrawerFunc: () => Navigator.pop(context),
          );
        }),
      ],
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text(
            LocaleKeys.map_screen_title.tr(),
            style: Theme.of(context).appBarTheme.titleTextStyle,
          ),
        ),
        body: Consumer<SearchButtonController>(builder: (context, value, _) {
          return WillPopScope(
            onWillPop: () async {
              if (drawerIsClosing) {
                drawerIsClosing = false;
                return true;
              }
              if (value.isSearchingElementActiveIfIsThatDeactiveIt()) {
                return false;
              }
              if (_wantUserExitApplication) {
                return true;
              } else {
                _wantUserExitApplication = true;
                Fluttertoast.showToast(
                  msg: LocaleKeys.want_you_exit.tr(),
                  fontSize: 16.0,
                );
                Future.delayed(Duration(milliseconds: 3000), () {
                  _wantUserExitApplication = false;
                });
                return false;
              }
            },
            child: Stack(
              children: [
                InteractiveMap(),
              ],
            ),
          );
        }),
        floatingActionButton: MapButtons(),
        drawer: WillPopScope(
          onWillPop: () async {
            drawerIsClosing = true;
            return true;
          },
          child: SideDrawer(),
        ),
      ),
    );
  }

  void _showCardFunc(MapItem mapItem) {
    _selectedMapItem = mapItem;
    Provider.of<VisitHistory>(context, listen: false).addItem(mapItem);
    Navigator.of(context).restorablePush(_dialogBuilder);
  }

  static Route<void> _dialogBuilder(BuildContext context, Object? arguments) {
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
}
