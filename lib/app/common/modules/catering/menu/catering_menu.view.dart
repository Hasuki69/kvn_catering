import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kvn_catering/app/common/modules/catering/menu/catering_menu.controller.dart';
import 'package:kvn_catering/app/common/widgets/custom_button.dart';
import 'package:kvn_catering/app/common/widgets/custom_dialog.dart';
import 'package:kvn_catering/app/common/widgets/custom_elevation.dart';
import 'package:kvn_catering/app/common/widgets/custom_listview.dart';
import 'package:kvn_catering/app/common/widgets/custom_text.dart';
import 'package:kvn_catering/app/core/configs/const.dart';
import 'package:kvn_catering/app/core/themes/theme.dart';
import 'package:kvn_catering/app/core/utils/extensions/string_currency.dart';

class CateringMenuView extends GetView<CateringMenuController> {
  const CateringMenuView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: cateringMenuAppbar(context, controller: controller),
      body: SingleChildScrollView(
        controller: ScrollController(),
        child: cateringMenuBody(context, controller: controller),
      ),
      floatingActionButton: cateringMenuFAB(context, controller: controller),
    );
  }
}

PreferredSizeWidget cateringMenuAppbar(BuildContext context,
    {required CateringMenuController controller}) {
  return AppBar(
    title: ReText(
      value: 'Menu',
      style: AppStyle().titleLarge,
    ),
  );
}

Widget cateringMenuBody(BuildContext context,
    {required CateringMenuController controller}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      cateringMenuBottomAppBar(context, controller: controller),
      cateringMenuListItem(context, controller: controller),
      const SizedBox(
        height: 24,
      ),
    ],
  );
}

Widget cateringMenuBottomAppBar(BuildContext context,
    {required CateringMenuController controller}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            cateringMenuBottomBarDate(context, controller: controller),
          ],
        ),
      ),
      const Divider(
        color: AppColor.disable,
        thickness: 4,
        height: 32,
      ),
    ],
  );
}

Widget cateringMenuBottomBarDate(BuildContext context,
    {required CateringMenuController controller}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16),
    child: Obx(
      () => GestureDetector(
        onTap: () {
          controller.callDatePicker(context);
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Wrap(
            alignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              const Icon(
                Icons.calendar_today,
                color: AppColor.accent,
              ),
              const SizedBox(
                width: 8,
              ),
              ReText(
                value: controller.selectedDate1(),
                style: AppStyle().titleSmall,
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

Widget cateringMenuListItem(BuildContext context,
    {required CateringMenuController controller}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    child: Obx(
      () => FutureBuilder(
        future: controller.futureCateringMenu(),
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
                      return ReListView(
                        itemCount: snapData[2][index]['menu'].length,
                        itemBuilder: (context, indexMenu) {
                          return ReElevation(
                            child: Card(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 16),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          ReText(
                                            value:
                                                '${snapData[2][index]['menu'][indexMenu]['jam_pengiriman_awal']} - ${snapData[2][index]['menu'][indexMenu]['jam_pengiriman_akhir']}',
                                            style: AppStyle().titleSmall,
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 16,
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Card(
                                                  clipBehavior: Clip.antiAlias,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                    side: BorderSide(
                                                      color: AppColor.accent
                                                          .withOpacity(0.4),
                                                      width: 1,
                                                    ),
                                                  ),
                                                  color: AppColor.background,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(8),
                                                    child: AspectRatio(
                                                      aspectRatio: 1,
                                                      child: Image(
                                                        fit: BoxFit.fitWidth,
                                                        loadingBuilder: (context,
                                                            child,
                                                            loadingProgress) {
                                                          if (loadingProgress ==
                                                              null) {
                                                            return child;
                                                          }
                                                          return const Center(
                                                            child:
                                                                CircularProgressIndicator(),
                                                          );
                                                        },
                                                        image: NetworkImage(
                                                          '$apiImagePath${snapData[2][index]['menu'][indexMenu]['foto_menu']}',
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 8,
                                              ),
                                              Expanded(
                                                flex: 3,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    ReText(
                                                      value: snapData[2][index]
                                                                  ['menu']
                                                              [indexMenu]
                                                          ['nama_menu'],
                                                      style: AppStyle()
                                                          .titleMedium
                                                          .copyWith(
                                                              fontSize: 18),
                                                      maxLines: 3,
                                                    ),
                                                    ReText(
                                                      value: CurrencyFormat.toIdr(
                                                          snapData[2][index]
                                                                      ['menu']
                                                                  [indexMenu]
                                                              ['harga_menu'],
                                                          0),
                                                      style:
                                                          AppStyle().bodyLarge,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        controller.setController(
                                            data: snapData[2][index]['menu']
                                                [indexMenu]);
                                        Get.dialog(
                                          menuDialog(context,
                                              controller: controller,
                                              menuUid: snapData[2][index]
                                                      ['menu'][indexMenu]
                                                  ['id_menu'],
                                              isEdit: true),
                                        );
                                      },
                                      child: ReText(
                                        value: 'Edit',
                                        style: AppStyle().titleSmall.copyWith(
                                              color: AppColor.accent,
                                            ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
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

Widget cateringMenuFAB(BuildContext context,
    {required CateringMenuController controller}) {
  return FloatingActionButton(
    backgroundColor: AppColor.accent,
    onPressed: () {
      Get.dialog(
        menuDialog(context, controller: controller),
      );
    },
    child: const Icon(
      Icons.add,
      color: AppColor.primary,
    ),
  );
}

Widget menuDialog(
  BuildContext context, {
  required CateringMenuController controller,
  bool isEdit = false,
  String menuUid = '',
}) {
  return ReActionDialog(
    onCancel: () {
      controller.clearForm();
      Get.back();
    },
    onConfirm: () {
      !isEdit
          ? controller.inputMenu()
          : controller.updateMenu(menuUid: menuUid);
    },
    title: 'Tambah Menu',
    children: [
      TextButton(
        onPressed: () {
          controller.callDatePickerInput(context);
        },
        child: ReText(
          value: 'Tanggal: ${controller.currDate1()}',
          style: AppStyle().titleMedium,
        ),
      ),
      const SizedBox(
        width: 8,
      ),
      ReText(
        value: 'Nama Menu',
        style: AppStyle().titleMedium.copyWith(color: AppColor.accent),
      ),
      const SizedBox(
        width: 8,
      ),
      ReTextField(
        controller: controller.tecNamaMenu,
      ),
      const SizedBox(
        width: 8,
      ),
      ReText(
        value: 'Harga Menu',
        style: AppStyle().titleMedium.copyWith(color: AppColor.accent),
      ),
      const SizedBox(
        width: 8,
      ),
      ReTextField(
        keyboardType: TextInputType.number,
        controller: controller.tecHarga,
      ),
      const SizedBox(
        width: 8,
      ),
      GetBuilder<CateringMenuController>(
        builder: (controller) {
          return Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () async => controller.tecJamAwal.text =
                      await controller.callTimePicker(
                          context, controller.selectedTime),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ReText(
                        value: 'Jam Awal',
                        style: AppStyle()
                            .titleMedium
                            .copyWith(color: AppColor.accent),
                      ),
                      AbsorbPointer(
                        child: ReTextField(
                          controller: controller.tecJamAwal,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () async => controller.tecJamAkhir.text =
                      await controller.callTimePicker(
                          context, controller.selectedTime),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ReText(
                        value: 'Jam Akhir',
                        style: AppStyle()
                            .titleMedium
                            .copyWith(color: AppColor.accent),
                      ),
                      AbsorbPointer(
                        child: ReTextField(
                          controller: controller.tecJamAkhir,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
      if (!isEdit)
        Column(
          children: [
            const SizedBox(
              height: 16,
            ),
            GetBuilder<CateringMenuController>(
              builder: (controller) {
                return Row(
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
                        value: 'Upload Foto',
                        style: AppStyle()
                            .titleMedium
                            .copyWith(color: AppColor.onAccent),
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
    ],
  );
}
