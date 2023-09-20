import 'package:flutter/material.dart';
import 'package:kvn_catering/app/core/themes/theme.dart';

class ReElevatedButton extends StatelessWidget {
  final EdgeInsetsGeometry padding;
  final Widget child;
  final void Function()? onPressed;
  final double radius;
  const ReElevatedButton({
    super.key,
    this.padding = const EdgeInsets.all(2),
    required this.child,
    this.onPressed,
    this.radius = 8,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColor.accent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius),
          ),
        ),
        onPressed: onPressed,
        child: child,
      ),
    );
  }
}

class ReIconButton extends StatelessWidget {
  final EdgeInsetsGeometry padding;
  final Widget child;
  final void Function()? onPressed;
  final Color iconColor;
  final Color backgroundColor;
  const ReIconButton({
    super.key,
    this.padding = const EdgeInsets.all(2),
    required this.child,
    this.onPressed,
    this.backgroundColor = AppColor.accent,
    this.iconColor = AppColor.primary,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: AppColor.disable.withOpacity(0.4),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: IconButton.filled(
        style: ButtonStyle(
          iconColor: MaterialStatePropertyAll(iconColor),
          backgroundColor: MaterialStatePropertyAll(backgroundColor),
        ),
        onPressed: onPressed,
        icon: child,
      ),
    );
  }
}
