import 'package:flutter/material.dart';
import 'package:kvn_catering/app/common/modules/delivery/delivery.controller.dart';
import 'package:kvn_catering/app/common/widgets/custom_text.dart';
import 'package:kvn_catering/app/core/configs/const.dart';
import 'package:kvn_catering/app/core/themes/theme.dart';

Widget deliverySidebar(BuildContext context,
    {required DeliveryController controller}) {
  return Drawer(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        deliverySidebarHeader(context, controller: controller),
        deliverySidebarContent(context, controller: controller),
      ],
    ),
  );
}

Widget deliverySidebarHeader(BuildContext context,
    {required DeliveryController controller}) {
  return DrawerHeader(
    decoration: const BoxDecoration(),
    child: Image.asset(appLogoIcon),
  );
}

Widget deliverySidebarContent(BuildContext context,
    {required DeliveryController controller}) {
  return Expanded(
    child: ListView(
      padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
      children: [
        ListTile(
          leading: const Icon(Icons.logout_rounded),
          iconColor: AppColor.accent,
          title: ReText(
            value: 'Logout',
            style: AppStyle().titleMedium.copyWith(
                  color: AppColor.accent,
                ),
          ),
          onTap: () {
            controller.logout();
          },
        ),
      ],
    ),
  );
}
