import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kvn_catering/app/common/modules/catering/location/catering_location.controller.dart';
import 'package:kvn_catering/app/common/widgets/custom_text.dart';

class CateringLocationView extends GetView<CateringLocationController> {
  const CateringLocationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: SingleChildScrollView(
        controller: ScrollController(),
        child: cateringLocationBody(context, controller: controller),
      ),
    );
  }
}

Widget cateringLocationBody(BuildContext context,
    {required CateringLocationController controller}) {
  return const Padding(
    padding: EdgeInsets.symmetric(vertical: 24),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ReText(value: 'Location'),
      ],
    ),
  );
}
