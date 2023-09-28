import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kvn_catering/app/common/modules/catering/budgeting/catering_budgeting.controller.dart';
import 'package:kvn_catering/app/common/modules/catering/budgeting/catering_budgeting_dialog.view.dart';
import 'package:kvn_catering/app/common/widgets/custom_button.dart';
import 'package:kvn_catering/app/common/widgets/custom_elevation.dart';
import 'package:kvn_catering/app/common/widgets/custom_listview.dart';
import 'package:kvn_catering/app/common/widgets/custom_text.dart';
import 'package:kvn_catering/app/core/themes/theme.dart';
import 'package:kvn_catering/app/core/utils/extensions/string_currency.dart';

class CateringBudgetingFormView extends GetView<CateringBudgetingController> {
  const CateringBudgetingFormView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: budgetingFormAppbar(context, controller: controller),
      body: SingleChildScrollView(
        controller: ScrollController(),
        child: budgetingFormBody(context, controller: controller),
      ),
    );
  }
}

PreferredSizeWidget budgetingFormAppbar(BuildContext context,
    {required CateringBudgetingController controller}) {
  return AppBar(
    title: ReText(
      value: 'Buat Budgeting',
      style: AppStyle().titleLarge,
    ),
  );
}

Widget budgetingFormBody(BuildContext context,
    {required CateringBudgetingController controller}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ReText(
          value: 'Nama Menu',
          style: AppStyle().titleMedium.copyWith(color: AppColor.accent),
        ),
        ReTextField(
          controller: controller.tecNamaMenu,
          hintText: 'Masukkan Nama Menu',
        ),
        const SizedBox(height: 8),
        ReText(
          value: 'Total Porsi',
          style: AppStyle().titleMedium.copyWith(color: AppColor.accent),
        ),
        ReTextField(
          controller: controller.tecPorsi,
          hintText: 'Masukkan Total Porsi',
          keyboardType: TextInputType.number,
        ),
        const SizedBox(height: 8),
        ReText(
          value: 'Tanggal',
          style: AppStyle().titleMedium.copyWith(color: AppColor.accent),
        ),
        GestureDetector(
          onTap: () => controller.callDatePicker(context),
          child: AbsorbPointer(
            child: ReTextField(
              controller: controller.tecTanggal,
              hintText: 'Pilih Tanggal',
              keyboardType: TextInputType.datetime,
              suffixIcon: const Icon(
                Icons.calendar_month,
                color: AppColor.accent,
                size: 24,
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        ReText(
          value: 'Bahan',
          style: AppStyle().titleMedium.copyWith(color: AppColor.accent),
        ),
        Obx(
          () => Container(
            decoration: BoxDecoration(
              color: AppColor.disable.withOpacity(0.4),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  controller.listBahan().isEmpty
                      ? const Center(
                          child: ReText(
                            value: 'Belum ada bahan',
                          ),
                        )
                      : Obx(
                          () => ReListView(
                            itemCount: controller.listBahan().length,
                            itemBuilder: (context, index) {
                              return ReElevation(
                                child: Card(
                                  child: ListTile(
                                    dense: true,
                                    title: ReText(
                                      value:
                                          '${controller.listBahan()[index]['nama']}',
                                    ),
                                    subtitle: ReText(
                                      value:
                                          '${controller.listBahan()[index]['jumlah']} ${controller.listBahan()[index]['satuan']}',
                                    ),
                                    trailing: Wrap(
                                      crossAxisAlignment:
                                          WrapCrossAlignment.center,
                                      children: [
                                        ReText(
                                          value: CurrencyFormat.toIdr(
                                              controller.listBahan()[index]
                                                  ['budget'],
                                              0),
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            controller.removeItemAt(index);
                                          },
                                          icon: Icon(
                                            Icons.delete,
                                            color: Colors.red.withOpacity(0.6),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton.filled(
                        style: IconButton.styleFrom(
                          backgroundColor: AppColor.accent,
                        ),
                        onPressed: () => Get.dialog(
                          bahanDialog(context, controller: controller),
                          barrierDismissible: false,
                        ).whenComplete(
                          () => controller.clearFormBahan(),
                        ),
                        icon: const Icon(
                          Icons.add,
                          color: AppColor.primary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        ReElevatedButton(
          onPressed: () {
            controller.postBudgeting();
          },
          child: ReText(
            value: 'Buat',
            style: AppStyle().titleMedium.copyWith(color: AppColor.onAccent),
          ),
        ),
      ],
    ),
  );
}
