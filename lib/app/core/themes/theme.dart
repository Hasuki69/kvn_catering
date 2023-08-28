import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kvn_catering/app/core/themes/theme.dart';
export 'color.dart';
export 'style.dart';

abstract class MainTheme {
  const MainTheme();
}

class AppTheme implements MainTheme {
  static ThemeData get appTheme => ThemeData(
        useMaterial3: true,
        primaryColor: AppColor.primary,
        scaffoldBackgroundColor: AppColor.background,
        appBarTheme: const AppBarTheme(
          color: AppColor.primary,
          elevation: 0,
          toolbarHeight: 64,
        ),
        drawerTheme: const DrawerThemeData(
          backgroundColor: AppColor.primary,
          elevation: 0,
        ),
        cardTheme: const CardTheme(
          clipBehavior: Clip.antiAlias,
          color: AppColor.primary,
          elevation: 0,
          shadowColor: AppColor.primary,
        ),
      );
}

Future setSystemUIOverlayStyle(final Color color) async {
  // Setting SystemUIMode
  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.edgeToEdge,
    overlays: [SystemUiOverlay.bottom],
  );

  // Setting SystemUIOverlay
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      systemStatusBarContrastEnforced: true,
      statusBarColor: color.withOpacity(0.002),
      systemNavigationBarColor: color.withOpacity(0.002),
      systemNavigationBarDividerColor: color.withOpacity(0.002),
      systemNavigationBarIconBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.dark,
    ),
  );

  // Setting Orientation
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
}
