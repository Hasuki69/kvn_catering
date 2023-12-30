import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kvn_catering/app/common/modules/user/catering/catering_list.controller.dart';
import 'package:kvn_catering/app/common/widgets/custom_button.dart';
import 'package:kvn_catering/app/common/widgets/custom_elevation.dart';
import 'package:kvn_catering/app/common/widgets/custom_listview.dart';
import 'package:kvn_catering/app/common/widgets/custom_text.dart';
import 'package:kvn_catering/app/core/configs/const.dart';
import 'package:kvn_catering/app/core/themes/theme.dart';
import 'package:kvn_catering/app/core/utils/extensions/string_currency.dart';

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
      cateringDetailListItem(context, controller: controller),
    ],
  );
}

Widget cateringDetailAppBar(BuildContext context,
    {required CateringListController controller}) {
  return SizedBox(
    height: 300,
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
                  maxLines: 3,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 8,
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
                  value: Get.arguments['catering-data']['deskripsi_catering'],
                  style: AppStyle().bodyLarge,
                  maxLines: 4,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 16,
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
                  onPressed: () {
                    controller.addFav(
                        idCat: Get.arguments['catering-data']['id_catering']);
                  },
                  icon: Icon(
                    Icons.favorite,
                    size: 36,
                    color: Get.arguments['catering-data']['favorite'] == 0
                        ? AppColor.disable
                        : Colors.amber,
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
          controller.setSelectedDate();
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
      () => GestureDetector(
        onTap: () {
          controller.callDatePicker(context);
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (controller.selectedFilter() != '')
                Wrap(
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
              if (controller.selectedFilter() == 'Mingguan' ||
                  controller.selectedFilter() == 'Bulanan')
                Row(
                  children: [
                    const SizedBox(
                      width: 16,
                    ),
                    ReText(
                      value: 's/d',
                      style: AppStyle().bodySmall,
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    ReText(
                      value: controller.selectedDate2(),
                      style: AppStyle().titleSmall,
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    ),
  );
}

Widget cateringDetailListItem(BuildContext context,
    {required CateringListController controller}) {
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
                      controller.menuItem(
                        List.generate(
                          snapData[2].length,
                          (indexItem) => List.generate(
                            snapData[2][indexItem]['menu'].length,
                            (indexMenu) => [
                              snapData[2][indexItem]['menu'][indexMenu]
                                  ['id_menu'],
                              snapData[2][indexItem]['menu'][indexMenu]
                                  ['nama_menu'],
                              0,
                              snapData[2][indexItem]['menu'][indexMenu]
                                  ['harga_menu'],
                              snapData[2][indexItem]['tanggal_menu'],
                            ],
                          ),
                        ),
                      );

                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ReText(
                            value: '${snapData[2][index]['tanggal_menu']}',
                            style: AppStyle().titleLarge.copyWith(
                                  fontSize: 18,
                                ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                          ),
                          ReListView(
                            itemCount: snapData[2][index]['menu'].length,
                            itemBuilder: (context, indexMenu) {
                              return ReElevation(
                                child: Card(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8, horizontal: 16),
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
                                                      BorderRadius.circular(8),
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
                                              child: Stack(
                                                children: [
                                                  Align(
                                                    alignment:
                                                        Alignment.topRight,
                                                    child: IconButton(
                                                      onPressed: () {
                                                        Get.dialog(
                                                          Dialog(
                                                            elevation: 0,
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .stretch,
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
                                                              children: [
                                                                ReText(
                                                                  value:
                                                                      "Description: ",
                                                                  style: AppStyle()
                                                                      .titleSmall
                                                                      .copyWith(
                                                                        color: Colors
                                                                            .amber,
                                                                      ),
                                                                ),
                                                                ReText(
                                                                  value: snapData[2][index]
                                                                              [
                                                                              'menu']
                                                                          [
                                                                          indexMenu]
                                                                      [
                                                                      'deskripsi_menu'],
                                                                  maxLines: 5,
                                                                ),
                                                                ReText(
                                                                  value:
                                                                      "List Bahan: ",
                                                                  style: AppStyle()
                                                                      .titleSmall
                                                                      .copyWith(
                                                                        color: Colors
                                                                            .amber,
                                                                      ),
                                                                ),
                                                                ListView
                                                                    .builder(
                                                                  shrinkWrap:
                                                                      true,
                                                                  itemCount: snapData[2][index]['menu']
                                                                              [
                                                                              indexMenu]
                                                                          [
                                                                          'bahan_menu']
                                                                      .length,
                                                                  itemBuilder:
                                                                      (context,
                                                                          indexItem) {
                                                                    final item =
                                                                        snapData[2][index]['menu'][indexMenu]['bahan_menu'][indexItem]
                                                                            [
                                                                            'nama_bahan_menu'];
                                                                    return ReText(
                                                                        value:
                                                                            "${indexItem + 1}. $item");
                                                                  },
                                                                ),
                                                              ],
                                                            ).paddingAll(16),
                                                          ),
                                                        );
                                                      },
                                                      icon: const Icon(
                                                        Icons.list_alt,
                                                        color: Colors.amber,
                                                      ),
                                                    ),
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      ReText(
                                                        value: snapData[2]
                                                                        [index]
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
                                                        style: AppStyle()
                                                            .bodyLarge,
                                                      ),
                                                      StatefulBuilder(
                                                        builder: (context,
                                                            setState) {
                                                          return Row(
                                                            children: [
                                                              const Spacer(),
                                                              IconButton(
                                                                color: AppColor
                                                                    .accent,
                                                                onPressed: () {
                                                                  if (controller
                                                                              .menuItem[index]
                                                                          [
                                                                          indexMenu][2] >
                                                                      0) {
                                                                    controller.menuItem[index]
                                                                            [
                                                                            indexMenu]
                                                                        [
                                                                        2] -= 1;
                                                                    controller
                                                                        .itemCount
                                                                        .value -= 1;
                                                                  }
                                                                  if (context
                                                                      .mounted) {
                                                                    setState(
                                                                        () {});
                                                                  }
                                                                },
                                                                icon: const Icon(
                                                                    Icons
                                                                        .remove),
                                                              ),
                                                              ReText(
                                                                value:
                                                                    '${controller.menuItem[index][indexMenu][2]}',
                                                                style: AppStyle()
                                                                    .titleMedium,
                                                              ),
                                                              IconButton(
                                                                color: AppColor
                                                                    .accent,
                                                                onPressed: () {
                                                                  controller.menuItem[
                                                                              index]
                                                                          [
                                                                          indexMenu]
                                                                      [2] += 1;
                                                                  controller
                                                                      .itemCount
                                                                      .value += 1;
                                                                  if (context
                                                                      .mounted) {
                                                                    setState(
                                                                        () {});
                                                                  }
                                                                },
                                                                icon: const Icon(
                                                                    Icons.add),
                                                              ),
                                                            ],
                                                          );
                                                        },
                                                      )
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      );
                    },
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 56),
                    child: Obx(
                      () => ReElevatedButton(
                        onPressed: controller.itemCount() > 0
                            ? () {
                                controller.getSelectedMenu();
                                Get.toNamed(
                                    '/user/catering-list/detail-payment',
                                    arguments: {
                                      'catering-data':
                                          Get.arguments['catering-data'],
                                    });
                              }
                            : null,
                        child: ReText(
                          value: 'Pesan Sekarang',
                          style: AppStyle().titleSmall.copyWith(
                                color: AppColor.primary,
                              ),
                        ),
                      ),
                    ),
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
