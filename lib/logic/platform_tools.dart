import 'dart:io';

import 'package:flutter/foundation.dart';

abstract class PlatformTools {
  static String getIconsDir() =>
      _isPlatformMobile() ? _getDirBasedOnPlatform() : 'assets/images/icons/';

  static String _getDirBasedOnPlatform() =>
      Platform.isAndroid ? 'assets/images/icons/' : 'assets/images/icons/ios_';

  static bool _isPlatformMobile() => !kIsWeb;
}
