import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kampus_sggw/global_widgets/side_drawer.dart';
import 'package:kampus_sggw/logic/controllers/search_button_controller.dart';
import 'package:kampus_sggw/screens/map_screen/interactive_map.dart';
import 'package:kampus_sggw/screens/map_screen/map_buttons.dart';
import 'package:kampus_sggw/translations/locale_keys.g.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  bool _doesUserConfirmAppExit = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onReturnButtonTap(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: _appBar(),
        body: Stack(
          children: [
            InteractiveMap(),
          ],
        ),
        floatingActionButton: MapButtons(),
        drawer: SideDrawer(),
      ),
    );
  }

  Future<bool> _onReturnButtonTap() async {
    SearchButtonController searchButtonController =
        Provider.of<SearchButtonController>(context, listen: false);
    if (Navigator.canPop(context)) {
      Navigator.of(context).pop();
      return false;
    }
    if (searchButtonController.areMarkersFiltered) {
      searchButtonController.restoreMarkersWithReturnButton();
      return false;
    }
    if (_doesUserConfirmAppExit) {
      return true;
    } else {
      _doesUserConfirmAppExit = true;
      Fluttertoast.showToast(
        msg: LocaleKeys.want_you_exit.tr(),
        fontSize: 16.0,
      );
      Future.delayed(
          Duration(milliseconds: 3000), () => _doesUserConfirmAppExit = false);
      return false;
    }
  }

  AppBar _appBar() {
    return AppBar(
      title: Text(
        LocaleKeys.map_screen_title.tr(),
        style: Theme.of(context).appBarTheme.titleTextStyle,
      ),
    );
  }
}
