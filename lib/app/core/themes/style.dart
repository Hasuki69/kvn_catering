import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kvn_catering/app/core/themes/color.dart';

abstract class AppStyleTheme {
  const AppStyleTheme();
}

class AppStyle implements AppStyleTheme {
  TextStyle displayLarge = GoogleFonts.workSans(
    fontSize: 57,
    fontWeight: FontWeight.w800,
    color: AppColor.netral,
  );

  TextStyle displayMedium = GoogleFonts.workSans(
    fontSize: 45,
    fontWeight: FontWeight.w800,
    color: AppColor.netral,
  );

  TextStyle displaySmall = GoogleFonts.workSans(
    fontSize: 36,
    fontWeight: FontWeight.w800,
    color: AppColor.netral,
  );

  // ==================== Heading TextStyle ====================

  TextStyle headingLarge = GoogleFonts.workSans(
    fontSize: 32,
    fontWeight: FontWeight.w700,
    color: AppColor.netral,
  );

  TextStyle headingMedium = GoogleFonts.workSans(
    fontSize: 28,
    fontWeight: FontWeight.w700,
    color: AppColor.netral,
  );

  TextStyle headingSmall = GoogleFonts.workSans(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    color: AppColor.netral,
  );

  // ==================== Title TextStyle ====================

  TextStyle titleLarge = GoogleFonts.workSans(
    fontSize: 22,
    fontWeight: FontWeight.w600,
    color: AppColor.netral,
  );

  TextStyle titleMedium = GoogleFonts.workSans(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColor.netral,
  );

  TextStyle titleSmall = GoogleFonts.workSans(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColor.netral,
  );

  // ==================== Body TextStyle ====================

  TextStyle bodyLarge = GoogleFonts.workSans(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: AppColor.netral,
  );

  TextStyle bodyMedium = GoogleFonts.workSans(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColor.netral,
  );

  TextStyle bodySmall = GoogleFonts.workSans(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: AppColor.netral,
  );

  // ==================== Caption | Label TextStyle ====================

  TextStyle captionLarge = GoogleFonts.workSans(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColor.netral,
  );

  TextStyle captionMedium = GoogleFonts.workSans(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColor.netral,
  );

  TextStyle captionSmall = GoogleFonts.workSans(
    fontSize: 10,
    fontWeight: FontWeight.w400,
    color: AppColor.netral,
  );
}
