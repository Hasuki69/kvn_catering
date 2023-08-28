import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kvn_catering/app/core/configs/const.dart';
import 'package:kvn_catering/app/core/configs/responsive.dart';
import 'package:kvn_catering/app/core/routes/route.dart';
import 'package:kvn_catering/app/core/themes/theme.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Catering App',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.appTheme,
      builder: (context, child) => responsiveBuilder(context, child: child!),
      initialRoute: initialRoute,
      getPages: getPages,
    );
  }
}
