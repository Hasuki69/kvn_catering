import 'package:flutter/material.dart';
import 'package:kvn_catering/app/core/themes/color.dart';

class ReElevation extends StatelessWidget {
  final Widget child;
  final Offset offset;
  final double blurRadius;

  const ReElevation({
    super.key,
    required this.child,
    this.offset = const Offset(0, 4),
    this.blurRadius = 8,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: AppColor.netral.withOpacity(0.1),
            blurRadius: blurRadius,
            offset: offset,
          ),
        ],
      ),
      child: child,
    );
  }
}
