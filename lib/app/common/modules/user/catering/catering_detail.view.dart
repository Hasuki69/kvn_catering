import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kvn_catering/app/common/modules/user/catering/catering_list.controller.dart';
import 'package:kvn_catering/app/common/widgets/custom_elevation.dart';
import 'package:kvn_catering/app/common/widgets/custom_text.dart';
import 'package:kvn_catering/app/core/themes/theme.dart';

class CateringDetailView extends GetView<CateringListController> {
  const CateringDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: SingleChildScrollView(
        controller: ScrollController(),
        child: cateringDetailBody(context, controller: controller),
      ),
    );
  }
}

Widget cateringDetailBody(BuildContext context,
    {required CateringListController controller}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      cateringDetailAppBar(context, controller: controller),
      cateringDetailBottomAppBar(context, controller: controller),
      cateringDetailItemList(context, controller: controller),
    ],
  );
}

Widget cateringDetailAppBar(BuildContext context,
    {required CateringListController controller}) {
  return SizedBox(
    height: 250,
    child: Stack(
      children: [
        Container(
          height: 180,
          decoration: const BoxDecoration(
            color: AppColor.accent,
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(16),
            ),
            boxShadow: [
              BoxShadow(
                color: AppColor.disable,
                blurRadius: 8,
                offset: Offset(0, 4), // changes position of shadow
              ),
            ],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 32, 16, 16),
              child: IconButton.filled(
                style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(
                    AppColor.background,
                  ),
                  iconColor: MaterialStatePropertyAll(
                    AppColor.accent,
                  ),
                ),
                onPressed: () {
                  Get.back();
                },
                icon: const Icon(
                  Icons.arrow_back_rounded,
                ),
              ),
            ),
            const Spacer(),
            cateringDetailAppbarCard(context, controller: controller),
          ],
        ),
      ],
    ),
  );
}

Widget cateringDetailAppbarCard(BuildContext context,
    {required CateringListController controller}) {
  return ReElevation(
    child: Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        color: AppColor.background,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColor.accent,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
            child: ReText(
              value: Get.arguments['catering-data']['nama_catering'] ??
                  'Catering Name',
              style: AppStyle().headingMedium,
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            children: [
              const Expanded(
                child: Icon(
                  Icons.pin_drop,
                ),
              ),
              Expanded(
                flex: 5,
                child: ReText(
                  value: Get.arguments['catering-data']['alamat_catering'] ??
                      'Catering Address',
                  style: AppStyle().bodyLarge,
                ),
              ),
            ],
          ),
          Row(
            children: [
              const Expanded(
                child: Icon(
                  Icons.description_rounded,
                ),
              ),
              Expanded(
                flex: 5,
                child: ReText(
                  value:
                      'Kami menerima berbaigai macam layanan catering, semat menikmati :)',
                  style: AppStyle().bodyLarge,
                  maxLines: 4,
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

Widget cateringDetailBottomAppBar(BuildContext context,
    {required CateringListController controller}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const SizedBox(height: 16),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                cateringDetailBottomBarDropdown(context,
                    controller: controller),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.favorite,
                    size: 36,
                    color: AppColor.disable,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            cateringDetailBottomBarDate(context, controller: controller),
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

Widget cateringDetailBottomBarDropdown(BuildContext context,
    {required CateringListController controller}) {
  return ReElevation(
    child: Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      clipBehavior: Clip.antiAlias,
      child: DropdownMenu(
        initialSelection: controller.selectedFilter(),
        hintText: 'Pilih Tipe Pemesanan',
        
        trailingIcon: const Icon(
          Icons.arrow_drop_down,
          color: AppColor.accent,
        ),
        selectedTrailingIcon: const Icon(
          Icons.arrow_drop_up,
          color: AppColor.accent,
        ),
        inputDecorationTheme: InputDecorationTheme(
          isDense: true,
          iconColor: AppColor.accent,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              color: AppColor.accent,
              width: 1,
            ),
          ),
        ),
        onSelected: (value) {
          controller.selectedFilter(value);
        },
        dropdownMenuEntries: List.generate(
          Get.arguments['catering-data']['tipe_pemesanan'].length,
          (index) => DropdownMenuEntry(
            value: Get.arguments['catering-data']['tipe_pemesanan'][index],
            label: Get.arguments['catering-data']['tipe_pemesanan'][index],
          ),
        ),
      ),
    ),
  );
}

Widget cateringDetailBottomBarDate(BuildContext context,
    {required CateringListController controller}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16),
    child: Obx(
      () => Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          if (controller.selectedFilter() != '')
            Wrap(
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                const Icon(
                  Icons.calendar_today,
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
          if (controller.selectedFilter() == 'Mingguan' ||
              controller.selectedFilter() == 'Bulanan')
            Row(
              children: [
                const SizedBox(
                  width: 16,
                ),
                ReText(
                  value: 's/d',
                  style: AppStyle().titleSmall,
                ),
                const SizedBox(
                  width: 16,
                ),
              ],
            ),
          if (controller.selectedFilter() == 'Mingguan' ||
              controller.selectedFilter() == 'Bulanan')
            Wrap(
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                const Icon(
                  Icons.calendar_today,
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
        ],
      ),
    ),
  );
}

Widget cateringDetailItemList(BuildContext context,
    {required CateringListController controller}) {
  return Container();
}
