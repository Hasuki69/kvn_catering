import 'package:flutter/material.dart';

abstract class AppColorTheme {
  const AppColorTheme();
}

class AppColor implements AppColorTheme {
  static const Color primary = Color(0xFFffffff);
  static const Color onPrimary = Color(0xFF1e1e1e);

  static const Color accent = Color(0xFFf5c232);
  static const Color onAccent = Color(0xFFf6f0ea);

  static const Color netral = Color(0xFF1e1e1e);

  static const Color background = Color(0xFFffffff);
  static const Color onBackground = Color(0xFF1e1e1e);

  static const Color surface = Color(0xFFefefef);
  static const Color onSurface = Color(0xFF1e1e1e);

  static const Color disable = Color(0xFFcccccc);
  static const Color error = Color(0xFFcc4346);
  static const Color onError = Color(0xFFf6f0ea);

  MaterialColor getMaterialColor(Color color) {
    final int red = color.red;
    final int green = color.green;
    final int blue = color.blue;

    final Map<int, Color> shades = {
      50: Color.fromRGBO(red, green, blue, .1),
      100: Color.fromRGBO(red, green, blue, .2),
      200: Color.fromRGBO(red, green, blue, .3),
      300: Color.fromRGBO(red, green, blue, .4),
      400: Color.fromRGBO(red, green, blue, .5),
      500: Color.fromRGBO(red, green, blue, .6),
      600: Color.fromRGBO(red, green, blue, .7),
      700: Color.fromRGBO(red, green, blue, .8),
      800: Color.fromRGBO(red, green, blue, .9),
      900: Color.fromRGBO(red, green, blue, 1),
    };

    return MaterialColor(color.value, shades);
  }
}
