import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kvn_catering/app/common/modules/catering/order/catering_order.controller.dart';
import 'package:kvn_catering/app/common/widgets/custom_text.dart';

class CateringOrderView extends GetView<CateringOrderController> {
  const CateringOrderView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: SingleChildScrollView(
        controller: ScrollController(),
        child: cateringOrderBody(context, controller: controller),
      ),
    );
  }
}

Widget cateringOrderBody(BuildContext context,
    {required CateringOrderController controller}) {
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
