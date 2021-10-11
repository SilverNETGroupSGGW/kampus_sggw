import 'dart:io';

class PlatformTools {
  String getIconsDir() =>
      _isPlatformMobile() ? _getDirBasedOnPlatform() : 'assets/images/icons/';

  String _getDirBasedOnPlatform() =>
      Platform.isAndroid ? 'assets/images/icons/' : 'assets/images/icons/ios_';

  bool _isPlatformMobile() {
    try {
      return Platform.isAndroid || Platform.isIOS;
    } catch (e) {
      return false;
    }
  }
}
