import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kvn_catering/app/common/modules/catering/budgeting/catering_budgeting.controller.dart';
import 'package:kvn_catering/app/common/widgets/custom_text.dart';

class CateringBudgetingView extends GetView<CateringBudgetingController> {
  const CateringBudgetingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: SingleChildScrollView(
        controller: ScrollController(),
        child: cateringBudgetingBody(context, controller: controller),
      ),
    );
  }
}

Widget cateringBudgetingBody(BuildContext context,
    {required CateringBudgetingController controller}) {
  return const Padding(
    padding: EdgeInsets.symmetric(vertical: 24),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ReText(value: 'Budgeting'),
      ],
    ),
  );
}
