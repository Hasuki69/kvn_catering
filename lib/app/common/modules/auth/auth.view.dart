import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kvn_catering/app/common/modules/auth/account.view.dart';
import 'package:kvn_catering/app/common/modules/auth/auth.controller.dart';
import 'package:kvn_catering/app/common/widgets/custom_text.dart';
import 'package:kvn_catering/app/core/configs/const.dart';
import 'package:kvn_catering/app/core/themes/theme.dart';

class AuthView extends GetView<AuthController> {
  const AuthView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 24),
          child: authBody(context, controller: controller),
        ),
      ),
    );
  }
}

Widget authBody(BuildContext context, {required AuthController controller}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisSize: MainAxisSize.min,
    children: [
      header(context, controller: controller),
      logo(context, controller: controller),
      content(context, controller: controller),
    ],
  );
}

Widget header(BuildContext context, {required AuthController controller}) {
  return Align(
    alignment: Alignment.centerRight,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        ReText(
          value: 'Selamat Datang',
          style: AppStyle().displaySmall.copyWith(
                color: AppColor.accent,
              ),
        ),
        ReText(
          value:
              'Silahkan masukkan username & password yang telah terdaftar untuk melanjutkan ke halaman berikutnya',
          style: AppStyle().bodyMedium,
          maxLines: 3,
          textAlign: TextAlign.right,
        ),
      ],
    ),
  );
}

Widget logo(BuildContext context, {required AuthController controller}) {
  final size = MediaQuery.of(context).size;
  return Center(
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 64),
      child: SizedBox(
        width: size.width * 0.6,
        height: size.width * 0.6,
        child: Image.asset(appLogoIcon),
      ),
    ),
  );
}

Widget content(BuildContext context, {required AuthController controller}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 36),
        child: Card(
          elevation: 4,
          shadowColor: AppColor.disable.withOpacity(0.4),
          child: ClipRRect(
            clipBehavior: Clip.antiAlias,
            borderRadius: BorderRadius.circular(8),
            child: TabBar(
              tabs: controller.tabList,
              controller: controller.tabController,
              labelColor: AppColor.onAccent,
              unselectedLabelColor: AppColor.onPrimary,
              indicatorColor: AppColor.accent,
              indicatorSize: TabBarIndicatorSize.tab,
              splashBorderRadius: BorderRadius.circular(8),
              indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: AppColor.accent,
              ),
            ),
          ),
        ),
      ),
      const SizedBox(
        height: 56,
      ),
      AccountView(controller: controller),
    ],
  );
}
