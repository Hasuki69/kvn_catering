import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kvn_catering/app/common/modules/catering/pengantar/catering_pengantar.controller.dart';
import 'package:kvn_catering/app/common/widgets/custom_text.dart';

class CateringPengantarView extends GetView<CateringPengantarController> {
  const CateringPengantarView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: SingleChildScrollView(
        controller: ScrollController(),
        child: cateringPengantarBody(context, controller: controller),
      ),
    );
  }
}

Widget cateringPengantarBody(BuildContext context,
    {required CateringPengantarController controller}) {
  return const Padding(
    padding: EdgeInsets.symmetric(vertical: 24),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ReText(value: 'Pengantar'),
      ],
    ),
  );
}
