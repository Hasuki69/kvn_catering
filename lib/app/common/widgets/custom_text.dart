import 'package:flutter/material.dart';
import 'package:kvn_catering/app/core/themes/theme.dart';

class ReText extends StatelessWidget {
  final String value;
  final TextStyle style;
  final EdgeInsetsGeometry padding;
  final TextAlign textAlign;
  final TextOverflow overflow;
  final int? maxLines;
  final bool softWrap;
  const ReText({
    super.key,
    required this.value,
    required this.style,
    this.padding = const EdgeInsets.all(2),
    this.textAlign = TextAlign.start,
    this.overflow = TextOverflow.ellipsis,
    this.maxLines,
    this.softWrap = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      child: Text(
        value,
        style: style,
        textAlign: textAlign,
        overflow: overflow,
        maxLines: maxLines,
        softWrap: softWrap,
      ),
    );
  }
}

class ReTextField extends StatelessWidget {
  final EdgeInsetsGeometry padding;
  final TextEditingController? controller;
  final bool readOnly;
  final TextInputType keyboardType;
  final String? labelText;
  final String? hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final bool filled;
  final Color fillColor;
  final double radius;
  final bool isDense;
  final bool obscureText;
  final int maxLines;
  const ReTextField({
    super.key,
    this.controller,
    this.readOnly = false,
    this.padding = const EdgeInsets.all(2),
    this.keyboardType = TextInputType.text,
    this.labelText,
    this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
    this.filled = true,
    this.fillColor = AppColor.surface,
    this.radius = 8,
    this.isDense = true,
    this.obscureText = false,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: TextFormField(
        validator: validator,
        controller: controller,
        readOnly: readOnly,
        keyboardType: keyboardType,
        obscureText: obscureText,
        maxLines: maxLines,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(radius),
            ),
            borderSide: BorderSide.none,
          ),
          isDense: isDense,
          filled: filled,
          fillColor: fillColor,
          labelText: labelText,
          hintText: hintText,
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          hintStyle: AppStyle().captionLarge.copyWith(
                color: AppColor.netral.withOpacity(0.4),
              ),
          labelStyle: AppStyle().captionLarge,
        ),
        style: AppStyle().bodyMedium,
      ),
    );
  }
}
