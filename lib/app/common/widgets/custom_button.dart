import 'package:flutter/material.dart';
import 'package:kvn_catering/app/core/themes/theme.dart';

class ReElevatedButton extends StatelessWidget {
  final EdgeInsetsGeometry padding;
  final Widget child;
  final void Function()? onPressed;
  const ReElevatedButton({
    super.key,
    this.padding = const EdgeInsets.all(2),
    required this.child,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColor.accent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        onPressed: onPressed,
        child: child,
      ),
    );
  }
}
