import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kampus_sggw/logic/controllers/search_button_controller.dart';
import 'package:kampus_sggw/translations/locale_keys.g.dart';
import 'package:provider/provider.dart';

class ReturnButtonController extends ChangeNotifier {
  bool _userConfirmsAppExit = false;

  Future<bool> onReturnButtonTap(BuildContext context) async {
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
    if (_userConfirmsAppExit) {
      return true;
    } else {
      _userConfirmsAppExit = true;
      Fluttertoast.showToast(
        msg: LocaleKeys.want_you_exit.tr(),
        fontSize: 16.0,
      );
      Future.delayed(Duration(milliseconds: 3000), () {
        _userConfirmsAppExit = false;
      });
      return false;
    }
  }
}
