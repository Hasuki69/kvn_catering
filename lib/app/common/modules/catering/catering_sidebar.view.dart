import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kvn_catering/app/common/modules/catering/catering.controller.dart';
import 'package:kvn_catering/app/common/widgets/custom_text.dart';
import 'package:kvn_catering/app/core/configs/const.dart';
import 'package:kvn_catering/app/core/themes/theme.dart';

Widget cateringSidebar(BuildContext context,
    {required CateringController controller}) {
  return Drawer(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        cateringSidebarHeader(context, controller: controller),
        cateringSidebarContent(context, controller: controller),
      ],
    ),
  );
}

Widget cateringSidebarHeader(BuildContext context,
    {required CateringController controller}) {
  return DrawerHeader(
    decoration: const BoxDecoration(),
    child: Image.asset(appLogoIcon),
  );
}

Widget cateringSidebarContent(BuildContext context,
    {required CateringController controller}) {
  return Expanded(
    child: ListView(
      padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
      children: [
        ListTile(
          leading: const Icon(Icons.person_outline_rounded),
          iconColor: AppColor.accent,
          title: ReText(
            value: 'Profile',
            style: AppStyle().titleMedium.copyWith(
                  color: AppColor.accent,
                ),
          ),
          onTap: () => Get.toNamed('/catering/profile'),
        ),
        ListTile(
          leading: const Icon(Icons.notifications_none_rounded),
          iconColor: AppColor.accent,
          title: ReText(
            value: 'Notification',
            style: AppStyle().titleMedium.copyWith(
                  color: AppColor.accent,
                ),
          ),
          onTap: () => Get.toNamed('/catering/notification'),
        ),
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
