import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kvn_catering/app/core/themes/color.dart';

abstract class AppStyleTheme {
  const AppStyleTheme();
}

class AppStyle implements AppStyleTheme {
  TextStyle displayLarge = GoogleFonts.sourceSansPro(
    fontSize: 57,
    fontWeight: FontWeight.w800,
    color: AppColor.netral,
  );

  TextStyle displayMedium = GoogleFonts.sourceSansPro(
    fontSize: 45,
    fontWeight: FontWeight.w800,
    color: AppColor.netral,
  );

  TextStyle displaySmall = GoogleFonts.sourceSansPro(
    fontSize: 36,
    fontWeight: FontWeight.w800,
    color: AppColor.netral,
  );

  // ==================== Heading TextStyle ====================

  TextStyle headingLarge = GoogleFonts.sourceSansPro(
    fontSize: 32,
    fontWeight: FontWeight.w700,
    color: AppColor.netral,
  );

  TextStyle headingMedium = GoogleFonts.sourceSansPro(
    fontSize: 28,
    fontWeight: FontWeight.w700,
    color: AppColor.netral,
  );

  TextStyle headingSmall = GoogleFonts.sourceSansPro(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    color: AppColor.netral,
  );

  // ==================== Title TextStyle ====================

  TextStyle titleLarge = GoogleFonts.sourceSansPro(
    fontSize: 22,
    fontWeight: FontWeight.w600,
    color: AppColor.netral,
  );

  TextStyle titleMedium = GoogleFonts.sourceSansPro(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColor.netral,
  );

  TextStyle titleSmall = GoogleFonts.sourceSansPro(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColor.netral,
  );

  // ==================== Body TextStyle ====================

  TextStyle bodyLarge = GoogleFonts.sourceSansPro(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: AppColor.netral,
  );

  TextStyle bodyMedium = GoogleFonts.sourceSansPro(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColor.netral,
  );

  TextStyle bodySmall = GoogleFonts.sourceSansPro(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: AppColor.netral,
  );

  // ==================== Caption | Label TextStyle ====================

  TextStyle captionLarge = GoogleFonts.sourceSansPro(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColor.netral,
  );

  TextStyle captionMedium = GoogleFonts.sourceSansPro(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColor.netral,
  );

  TextStyle captionSmall = GoogleFonts.sourceSansPro(
    fontSize: 10,
    fontWeight: FontWeight.w400,
    color: AppColor.netral,
  );
}
