import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

Widget responsiveBuilder(BuildContext context, {required Widget child}) {
  return ResponsiveWrapper.builder(
    child,
    maxWidth: 2460,
    minWidth: 480,
    defaultScale: true,
    breakpoints: const [
      ResponsiveBreakpoint.resize(480, name: MOBILE),
      ResponsiveBreakpoint.autoScale(800, name: TABLET, scaleFactor: 0.9),
      ResponsiveBreakpoint.resize(1200, name: DESKTOP),
      ResponsiveBreakpoint.autoScale(2460, name: "4K", scaleFactor: 0.9),
    ],
    background: Container(
      color: const Color(0xFFF5F5F5),
    ),
  );
}
