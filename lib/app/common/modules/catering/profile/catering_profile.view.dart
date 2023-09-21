import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kvn_catering/app/common/modules/catering/profile/catering_profile.controller.dart';
import 'package:kvn_catering/app/common/widgets/custom_button.dart';
import 'package:kvn_catering/app/common/widgets/custom_text.dart';
import 'package:kvn_catering/app/core/themes/theme.dart';

class CateringProfileView extends GetView<CateringProfileController> {
  const CateringProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: cateringProfileAppBar(context, controller: controller),
      body: SingleChildScrollView(
        controller: ScrollController(),
        child: cateringProfileBody(context, controller: controller),
      ),
    );
  }
}

PreferredSizeWidget cateringProfileAppBar(BuildContext context,
    {required CateringProfileController controller}) {
  return AppBar(
    centerTitle: true,
    forceMaterialTransparency: true,
    title: ReText(
      value: 'Profile',
      style: AppStyle().titleLarge,
    ),
    bottom: PreferredSize(
      preferredSize: const Size.fromHeight(1),
      child: Container(
        color: AppColor.onPrimary.withOpacity(0.05),
        height: 1,
      ),
    ),
  );
}

Widget cateringProfileBody(BuildContext context,
    {required CateringProfileController controller}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 24),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        cateringProfilePic(context, controller: controller),
        cateringProfileData(context, controller: controller),
      ],
    ),
  );
}

Widget cateringProfilePic(BuildContext context,
    {required CateringProfileController controller}) {
  final size = MediaQuery.of(context).size;
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
    child: Center(
      child: Container(
        width: size.width * 0.4,
        height: size.width * 0.4,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: AppColor.netral.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
          border: Border.all(
            color: AppColor.onPrimary.withOpacity(0.1),
            width: 2,
          ),
          shape: BoxShape.circle,
          color: AppColor.primary,
          image: const DecorationImage(
            image: NetworkImage(
              'https://picsum.photos/200',
            ),
            fit: BoxFit.cover,
          ),
        ),
      ),
    ),
  );
}

Widget cateringProfileData(BuildContext context,
    {required CateringProfileController controller}) {
  return Obx(
    () => FutureBuilder(
      future: controller.futureCateringProfile.value,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List snapData = snapshot.data! as List;
          controller.setControllerValue(snapData);
          if (snapData[0] != 404) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              child: Obx(
                () => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ReText(
                      value: 'Nama Catering',
                      style: AppStyle()
                          .titleMedium
                          .copyWith(color: AppColor.accent),
                    ),
                    ReTextField(
                      controller: controller.ctrlName,
                      hintText: 'Update Nama',
                      readOnly: controller.isReadOnly(),
                    ),
                    const SizedBox(height: 8),
                    ReText(
                      value: 'Alamat Catering',
                      style: AppStyle()
                          .titleMedium
                          .copyWith(color: AppColor.accent),
                    ),
                    ReTextField(
                      controller: controller.ctrlAddress,
                      hintText: 'Update Alamat',
                      readOnly: controller.isReadOnly(),
                    ),
                    const SizedBox(height: 8),
                    ReText(
                      value: 'No. telp Catering',
                      style: AppStyle()
                          .titleMedium
                          .copyWith(color: AppColor.accent),
                    ),
                    ReTextField(
                      controller: controller.ctrlPhone,
                      hintText: 'Update No Telp',
                      readOnly: controller.isReadOnly(),
                    ),
                    const SizedBox(height: 8),
                    ReText(
                      value: 'Email Catering',
                      style: AppStyle()
                          .titleMedium
                          .copyWith(color: AppColor.accent),
                    ),
                    ReTextField(
                      controller: controller.ctrlEmail,
                      hintText: 'Update Email',
                      readOnly: controller.isReadOnly(),
                    ),
                    const SizedBox(height: 8),
                    ReText(
                      value: 'Desc Catering',
                      style: AppStyle()
                          .titleMedium
                          .copyWith(color: AppColor.accent),
                    ),
                    ReTextField(
                      controller: controller.ctrlDesc,
                      hintText: 'Update Desc',
                      readOnly: controller.isReadOnly(),
                    ),
                    const SizedBox(height: 16),
                    // waktuPemesanan(context, controller: controller),
                    Row(
                      children: [
                        if (!controller.isReadOnly())
                          Expanded(
                            child: ReElevatedButton(
                              onPressed: () {
                                controller.setReadOnly();
                                controller.getCateringProfile(
                                    uid: controller.uid);
                                controller.setControllerValue(snapData);
                              },
                              child: ReText(
                                value: 'Cancel',
                                style: AppStyle().titleMedium.copyWith(
                                      color: AppColor.primary,
                                    ),
                              ),
                            ),
                          ),
                        if (!controller.isReadOnly()) const SizedBox(width: 8),
                        Expanded(
                          child: ReElevatedButton(
                            onPressed: () {
                              controller.isReadOnly()
                                  ? controller.setReadOnly()
                                  : controller
                                      .updateCateringProfile()
                                      .whenComplete(
                                        () => controller
                                            .setControllerValue(snapData),
                                      );
                            },
                            child: ReText(
                              value:
                                  controller.isReadOnly() ? 'Edit' : 'Simpan',
                              style: AppStyle().titleMedium.copyWith(
                                    color: AppColor.primary,
                                  ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          } else {
            return Center(
              child: ReText(
                value: 'No Profile Found!',
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
  );
}

/*
Widget waktuPemesanan(BuildContext context,
    {required CateringProfileController controller}) {
  return Obx(
    () => AbsorbPointer(
      absorbing: controller.isReadOnly(),
      child: Column(
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
                    padding:
                        const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
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
      ),
    ),
  );
}
*/
