import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kvn_catering/app/common/modules/catering/menu/catering_menu.controller.dart';
import 'package:kvn_catering/app/common/widgets/custom_text.dart';

class CateringMenuView extends GetView<CateringMenuController> {
  const CateringMenuView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: SingleChildScrollView(
        controller: ScrollController(),
        child: cateringMenuBody(context, controller: controller),
      ),
    );
  }
}

Widget cateringMenuBody(BuildContext context,
    {required CateringMenuController controller}) {
  return const Padding(
    padding: EdgeInsets.symmetric(vertical: 24),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ReText(value: 'Menu'),
      ],
    ),
  );
}
