import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kvn_catering/app/common/modules/user/profile/user_profile.controller.dart';
import 'package:kvn_catering/app/common/widgets/custom_button.dart';
import 'package:kvn_catering/app/common/widgets/custom_text.dart';
import 'package:kvn_catering/app/core/themes/theme.dart';

class UserProfileView extends GetView<UserProfileController> {
  const UserProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: userProfileAppBar(context, controller: controller),
      body: SingleChildScrollView(
        controller: ScrollController(),
        child: userProfileBody(context, controller: controller),
      ),
    );
  }
}

PreferredSizeWidget userProfileAppBar(BuildContext context,
    {required UserProfileController controller}) {
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

Widget userProfileBody(BuildContext context,
    {required UserProfileController controller}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 24),
    child: Column(
      children: [
        userProfilePic(context, controller: controller),
        userProfileData(context, controller: controller),
      ],
    ),
  );
}

Widget userProfilePic(BuildContext context,
    {required UserProfileController controller}) {
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

Widget userProfileData(BuildContext context,
    {required UserProfileController controller}) {
  return Obx(
    () => FutureBuilder(
      future: controller.futureProfile.value,
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
                      value: 'Nama',
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
                      value: 'Email',
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
                      value: 'No. telp',
                      style: AppStyle()
                          .titleMedium
                          .copyWith(color: AppColor.accent),
                    ),
                    ReTextField(
                      controller: controller.ctrlPhone,
                      hintText: 'Update No Telp',
                      readOnly: controller.isReadOnly(),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        if (!controller.isReadOnly())
                          Expanded(
                            child: ReElevatedButton(
                              onPressed: () {
                                controller.setReadOnly();
                                controller.getProfile(uid: controller.uid);
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
                                  : controller.updateProfile();
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
