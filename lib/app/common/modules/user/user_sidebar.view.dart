import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kvn_catering/app/common/modules/user/all_order/all_order.view.dart';
import 'package:kvn_catering/app/common/modules/user/user.controller.dart';
import 'package:kvn_catering/app/common/widgets/custom_text.dart';
import 'package:kvn_catering/app/core/configs/const.dart';
import 'package:kvn_catering/app/core/themes/theme.dart';

Widget userSidebar(BuildContext context, {required UserController controller}) {
  return Drawer(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        userSidebarHeader(context, controller: controller),
        userSidebarContent(context, controller: controller),
      ],
    ),
  );
}

Widget userSidebarHeader(BuildContext context,
    {required UserController controller}) {
  return DrawerHeader(
    decoration: const BoxDecoration(),
    child: Image.asset(appLogoIcon),
  );
}

Widget userSidebarContent(BuildContext context,
    {required UserController controller}) {
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
          onTap: () => Get.toNamed('/user/profile'),
        ),
        ListTile(
          leading: const Icon(Icons.receipt_outlined),
          iconColor: AppColor.accent,
          title: ReText(
            value: 'Recipt',
            style: AppStyle().titleMedium.copyWith(
                  color: AppColor.accent,
                ),
          ),
          onTap: () => Get.toNamed('/user/recipt'),
        ),
        ListTile(
          leading: const Icon(Icons.format_list_numbered_rounded),
          iconColor: AppColor.accent,
          title: ReText(
            value: 'Order',
            style: AppStyle().titleMedium.copyWith(
                  color: AppColor.accent,
                ),
          ),
          onTap: () => Get.toNamed(
            '/user/order',
            arguments: {'isHistory': false},
          ),
        ),
        ListTile(
          leading: const Icon(Icons.format_list_numbered_rounded),
          iconColor: AppColor.accent,
          title: ReText(
            value: 'View All Order (Today)',
            style: AppStyle().titleMedium.copyWith(
                  color: AppColor.accent,
                ),
          ),
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AllOrderView(
                idUser: controller.uid,
              ),
            ),
          ),
        ),
        ListTile(
          leading: const Icon(Icons.history_rounded),
          iconColor: AppColor.accent,
          title: ReText(
            value: 'History',
            style: AppStyle().titleMedium.copyWith(
                  color: AppColor.accent,
                ),
          ),
          onTap: () => Get.toNamed(
            '/user/order',
            arguments: {'isHistory': true},
          ),
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
