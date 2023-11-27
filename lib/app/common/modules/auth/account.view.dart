import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kvn_catering/app/common/modules/auth/auth.controller.dart';
import 'package:kvn_catering/app/common/widgets/custom_button.dart';
import 'package:kvn_catering/app/common/widgets/custom_text.dart';
import 'package:kvn_catering/app/core/themes/theme.dart';

class AccountView extends StatelessWidget {
  final AuthController controller;
  const AccountView({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (!controller.isLogin() && !controller.isCatering())
            isRegister(context, controller: controller),
          if (!controller.isCatering())
            isLogin(context, controller: controller),
          if (controller.isCatering())
            isCatering(context, controller: controller),
          submitButton(context, controller: controller),
        ],
      ),
    );
  }
}

Widget isLogin(BuildContext context, {required AuthController controller}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisSize: MainAxisSize.min,
    children: [
      ReText(
        value: 'Username',
        style: AppStyle().titleMedium.copyWith(color: AppColor.accent),
      ),
      ReTextField(
        controller: controller.ctrlUsername,
        hintText: 'Masukkan Username',
      ),
      const SizedBox(height: 8),
      ReText(
        value: 'Password',
        style: AppStyle().titleMedium.copyWith(color: AppColor.accent),
      ),
      Obx(
        () => ReTextField(
          controller: controller.ctrlPassword,
          hintText: 'Masukkan Password',
          obscureText: controller.isVisible(),
          suffixIcon: Opacity(
            opacity: 0.4,
            child: IconButton(
              onPressed: () => controller.passwordVisibility(),
              icon: Icon(controller.isVisible()
                  ? Icons.visibility
                  : Icons.visibility_off),
            ),
          ),
        ),
      ),
    ],
  );
}

Widget isRegister(BuildContext context, {required AuthController controller}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisSize: MainAxisSize.min,
    children: [
      ReText(
        value: 'Nama',
        style: AppStyle().titleMedium.copyWith(color: AppColor.accent),
      ),
      ReTextField(
        controller: controller.ctrlName,
        hintText: 'Masukkan Nama',
      ),
      const SizedBox(height: 8),
      ReText(
        value: 'Email',
        style: AppStyle().titleMedium.copyWith(color: AppColor.accent),
      ),
      ReTextField(
        controller: controller.ctrlEmail,
        hintText: 'Masukkan Email',
      ),
      const SizedBox(height: 8),
      ReText(
        value: 'No. telp',
        style: AppStyle().titleMedium.copyWith(color: AppColor.accent),
      ),
      ReTextField(
        controller: controller.ctrlTelp,
        hintText: 'Masukkan No Telp',
      ),
      const SizedBox(height: 8),
    ],
  );
}

Widget submitButton(BuildContext context,
    {required AuthController controller}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    mainAxisSize: MainAxisSize.min,
    children: [
      const SizedBox(height: 24),
      Obx(
        () => Row(
          children: [
            if (controller.isCatering())
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: ReElevatedButton(
                        onPressed: () {
                          controller.isCatering(false);
                        },
                        child: ReText(
                          value: 'Back',
                          style: AppStyle()
                              .titleMedium
                              .copyWith(color: AppColor.onAccent),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            if (!controller.isLogin() && !controller.isCatering())
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: ReElevatedButton(
                        onPressed: () {
                          controller.isCatering(true);
                        },
                        child: ReText(
                          value: 'Regis as Catering',
                          style: AppStyle()
                              .titleMedium
                              .copyWith(color: AppColor.onAccent),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            if (controller.isCatering() || !controller.isLogin())
              const SizedBox(
                width: 24,
              ),
            Expanded(
              child: ReElevatedButton(
                onPressed: () {
                  controller.auth();
                },
                child: ReText(
                  value: controller.isLogin()
                      ? 'Login'
                      : controller.isCatering()
                          ? 'Regis Catering'
                          : 'Regis as User',
                  style:
                      AppStyle().titleMedium.copyWith(color: AppColor.onAccent),
                ),
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

Widget isCatering(BuildContext context, {required AuthController controller}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisSize: MainAxisSize.min,
    children: [
      ReText(
        value: 'Nama Catering',
        style: AppStyle().titleMedium.copyWith(color: AppColor.accent),
      ),
      ReTextField(
        controller: controller.ctrlCateringName,
        hintText: 'Masukkan Nama Catering',
      ),
      const SizedBox(height: 8),
      ReText(
        value: 'Alamat Catering',
        style: AppStyle().titleMedium.copyWith(color: AppColor.accent),
      ),
      ReTextField(
        controller: controller.ctrlCateringAddress,
        hintText: 'Masukkan Alamat Catering',
      ),
      const SizedBox(height: 8),
      ReText(
        value: 'Email Catering',
        style: AppStyle().titleMedium.copyWith(color: AppColor.accent),
      ),
      ReTextField(
        controller: controller.ctrlCateringEmail,
        hintText: 'Masukkan Email Catering',
      ),
      const SizedBox(height: 8),
      ReText(
        value: 'No Rekening Catering',
        style: AppStyle().titleMedium.copyWith(color: AppColor.accent),
      ),
      ReTextField(
        controller: controller.ctrlCateringPhone,
        hintText: 'Masukkan No Rekening Catering',
      ),
      const SizedBox(height: 8),
      ReText(
        value: 'Deskripsi Catering',
        style: AppStyle().titleMedium.copyWith(color: AppColor.accent),
      ),
      ReTextField(
        controller: controller.ctrlCateringDescription,
        hintText: 'Masukkan Deskripsi Catering',
        maxLines: 4,
      ),
      const SizedBox(height: 8),
      waktuPemesanan(context, controller: controller),
      const SizedBox(height: 8),
      Row(
        children: [
          Expanded(
            child: Obx(
              () => ReText(
                value: controller.imageFile(),
              ),
            ),
          ),
          ReElevatedButton(
            onPressed: () {
              controller.pickFile();
            },
            child: ReText(
              value: 'Upload QR',
              style: AppStyle().titleMedium.copyWith(color: AppColor.onAccent),
            ),
          ),
        ],
      ),
    ],
  );
}

Widget waktuPemesanan(BuildContext context,
    {required AuthController controller}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisSize: MainAxisSize.min,
    children: [
      ReText(
        value: 'Waktu Pemesanan',
        style: AppStyle().titleMedium.copyWith(color: AppColor.accent),
      ),
      ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemCount: controller.waktuPemesanan().length,
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemBuilder: (context, index) {
          return StatefulBuilder(
            builder: (context, setState) => CheckboxListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              checkColor: AppColor.onAccent,
              activeColor: AppColor.accent,
              title: Container(
                padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColor.accent),
                ),
                child: ReText(
                    value: controller.waktuPemesanan()[index][0],
                    style: AppStyle().titleMedium),
              ),
              value: controller.waktuPemesanan()[index][1],
              onChanged: (val) {
                controller.waktuPemesanan()[index][1] = val!;
                setState(() {});
                debugPrint(controller.waktuPemesanan().toString());
              },
            ),
          );
        },
      ),
    ],
  );
}
