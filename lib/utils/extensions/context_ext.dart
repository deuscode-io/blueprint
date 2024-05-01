import 'package:flutter/material.dart';

extension BuildContextExtension on BuildContext {
  Color getThemeColor({required Color light, required Color dark}) {
    if (Theme.of(this).brightness == Brightness.dark) {
      return dark;
    }
    return light;
  }
}
