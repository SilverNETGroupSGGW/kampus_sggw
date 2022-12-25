import 'package:flutter/material.dart';

abstract class KeyboardUtils {
  static bool isOpen(BuildContext context) {
    return MediaQuery.of(context).viewInsets.bottom > 0.0;
  }

  static double keyboardHeight(BuildContext context) {
    return MediaQuery.of(context).viewInsets.bottom;
  }
}
