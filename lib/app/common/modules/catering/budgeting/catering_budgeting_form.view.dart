import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kvn_catering/app/common/modules/catering/budgeting/catering_budgeting.controller.dart';
import 'package:kvn_catering/app/common/widgets/custom_button.dart';
import 'package:kvn_catering/app/common/widgets/custom_text.dart';
import 'package:kvn_catering/app/core/themes/theme.dart';

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
          value: 'Pilih Menu',
          style: AppStyle().titleMedium.copyWith(color: AppColor.accent),
        ),
        DropdownMenu(
          inputDecorationTheme: const InputDecorationTheme(
            isDense: true,
            border: OutlineInputBorder(),
          ),
          onSelected: (value) => controller.selectedMasterMenu = value,
          dropdownMenuEntries: List.generate(
            controller.dropdownMasterMenu.length,
            (index) => DropdownMenuEntry(
              value: controller.dropdownMasterMenu[index][0],
              label: controller.dropdownMasterMenu[index][1],
            ),
          ),
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
