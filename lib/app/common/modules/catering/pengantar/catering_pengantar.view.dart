import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kvn_catering/app/common/modules/catering/pengantar/catering_pengantar.controller.dart';
import 'package:kvn_catering/app/common/widgets/custom_dialog.dart';
import 'package:kvn_catering/app/common/widgets/custom_elevation.dart';
import 'package:kvn_catering/app/common/widgets/custom_listview.dart';
import 'package:kvn_catering/app/common/widgets/custom_text.dart';
import 'package:kvn_catering/app/core/themes/theme.dart';

class CateringPengantarView extends GetView<CateringPengantarController> {
  const CateringPengantarView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: cateringPengantarAppbar(context, controller: controller),
      body: SingleChildScrollView(
        controller: ScrollController(),
        child: cateringPengantarBody(context, controller: controller),
      ),
      floatingActionButton:
          cateringPengantarFAB(context, controller: controller),
    );
  }
}

PreferredSizeWidget cateringPengantarAppbar(BuildContext context,
    {required CateringPengantarController controller}) {
  return AppBar(
    title: ReText(
      value: 'Pengantar',
      style: AppStyle().titleLarge,
    ),
  );
}

Widget cateringPengantarBody(BuildContext context,
    {required CateringPengantarController controller}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
    child: Obx(
      () => FutureBuilder(
        future: controller.futurePengantar(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List snapData = snapshot.data! as List;
            if (snapData[0] != 404) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ReListView(
                    itemCount: snapData[2].length,
                    itemBuilder: (context, index) {
                      return ReElevation(
                        child: Card(
                          child: ListTile(
                            leading: ReText(
                              value: snapData[2][index]['kode_pengantar'],
                            ),
                            title: Row(
                              children: [
                                const SizedBox(
                                  height: 32,
                                  child: VerticalDivider(
                                    color: AppColor.accent,
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ReText(
                                      value: snapData[2][index]
                                          ['nama_pengantar'],
                                      style: AppStyle().titleMedium,
                                    ),
                                    ReText(
                                      value: snapData[2][index]
                                          ['nomor_telp_pengantar'],
                                      style: AppStyle().bodyMedium.copyWith(
                                          color:
                                              AppColor.netral.withOpacity(0.6)),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            trailing: IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.delete),
                            ),
                          ),
                        ),
                      );
                    },
                  )
                ],
              );
            } else {
              return Center(
                child: ReText(
                  value: 'No Catering Found!',
                  style: AppStyle().titleLarge,
                ),
              );
            }
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    ),
  );
}

Widget cateringPengantarFAB(BuildContext context,
    {required CateringPengantarController controller}) {
  return FloatingActionButton(
    backgroundColor: AppColor.accent,
    onPressed: () {
      Get.dialog(
        addPengantarDialog(context, controller: controller),
      );
    },
    child: const Icon(
      Icons.add,
      color: AppColor.primary,
    ),
  );
}

Widget addPengantarDialog(BuildContext context,
    {required CateringPengantarController controller}) {
  return ReActionDialog(
    onCancel: () {
      controller.clearForm();
      Get.back();
    },
    onConfirm: () {
      controller.postPengantar();
    },
    title: 'Tambah Pengantar',
    children: [
      ReText(
        value: 'Nama Pengantar',
        style: AppStyle().titleMedium.copyWith(color: AppColor.accent),
      ),
      ReTextField(
        controller: controller.tecNama,
        hintText: 'Masukkan Nama Pengantar',
      ),
      const SizedBox(height: 8),
      ReText(
        value: 'Telp Pengantar',
        style: AppStyle().titleMedium.copyWith(color: AppColor.accent),
      ),
      ReTextField(
        controller: controller.tecTelp,
        hintText: 'Masukkan Telp Pengantar',
        keyboardType: TextInputType.phone,
      ),
      const SizedBox(height: 8),
      ReText(
        value: 'Email Pengantar',
        style: AppStyle().titleMedium.copyWith(color: AppColor.accent),
      ),
      ReTextField(
        controller: controller.tecEmail,
        hintText: 'Masukkan Email Pengantar',
      ),
      const SizedBox(height: 8),
      ReText(
        value: 'Username Pengantar',
        style: AppStyle().titleMedium.copyWith(color: AppColor.accent),
      ),
      ReTextField(
        controller: controller.tecUsername,
        hintText: 'Masukkan Username Pengantar',
      ),
      const SizedBox(height: 8),
      ReText(
        value: 'Password Pengantar',
        style: AppStyle().titleMedium.copyWith(color: AppColor.accent),
      ),
      Obx(
        () => ReTextField(
          controller: controller.tecPassword,
          hintText: 'Masukkan Password Pengantar',
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
