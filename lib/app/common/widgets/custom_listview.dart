import 'package:flutter/material.dart';

class ReListView extends StatelessWidget {
  final EdgeInsetsGeometry padding;
  final bool shrinkWrap;
  final ScrollController? controller;
  final ScrollPhysics physics;
  final int itemCount;
  final Widget? Function(BuildContext, int) itemBuilder;
  const ReListView({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
    this.padding = const EdgeInsets.all(0),
    this.shrinkWrap = true,
    this.controller,
    this.physics = const NeverScrollableScrollPhysics(),
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: padding,
      shrinkWrap: shrinkWrap,
      controller: controller,
      physics: physics,
      itemCount: itemCount,
      itemBuilder: itemBuilder,
    );
  }
}
