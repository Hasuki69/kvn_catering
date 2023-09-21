import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kvn_catering/app/common/modules/catering/notification/catering_notification.controller.dart';
import 'package:kvn_catering/app/common/widgets/custom_text.dart';

class CateringNotificationView extends GetView<CateringNotificationController> {
  const CateringNotificationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: SingleChildScrollView(
        controller: ScrollController(),
        child: cateringNotificationBody(context, controller: controller),
      ),
    );
  }
}

Widget cateringNotificationBody(BuildContext context,
    {required CateringNotificationController controller}) {
  return const Padding(
    padding: EdgeInsets.symmetric(vertical: 24),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ReText(value: 'Notification'),
      ],
    ),
  );
}
