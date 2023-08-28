import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kvn_catering/app/common/modules/delivery/delivery.controller.dart';
import 'package:kvn_catering/app/common/widgets/custom_button.dart';
import 'package:kvn_catering/app/common/widgets/custom_text.dart';
import 'package:kvn_catering/app/core/themes/theme.dart';

class DeliveryView extends GetView<DeliveryController> {
  const DeliveryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ReText(
              value: 'Delivery Home',
              style: AppStyle().displayMedium,
            ),
            ReElevatedButton(
              onPressed: () {
                controller.logout();
              },
              child: ReText(
                value: 'Logout',
                style:
                    AppStyle().titleMedium.copyWith(color: AppColor.onAccent),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
