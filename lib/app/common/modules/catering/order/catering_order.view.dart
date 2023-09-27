import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kvn_catering/app/common/modules/catering/order/catering_order.controller.dart';
import 'package:kvn_catering/app/common/widgets/custom_dialog.dart';
import 'package:kvn_catering/app/common/widgets/custom_elevation.dart';
import 'package:kvn_catering/app/common/widgets/custom_listview.dart';
import 'package:kvn_catering/app/common/widgets/custom_text.dart';
import 'package:kvn_catering/app/core/themes/theme.dart';
import 'package:kvn_catering/app/core/utils/extensions/string_currency.dart';

class CateringOrderView extends GetView<CateringOrderController> {
  const CateringOrderView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: cateringOrderAppbar(context, controller: controller),
      body: SingleChildScrollView(
        controller: ScrollController(),
        child: cateringOrderBody(context, controller: controller),
      ),
    );
  }
}

PreferredSizeWidget cateringOrderAppbar(BuildContext context,
    {required CateringOrderController controller}) {
  return AppBar(
    title: ReText(
      value: 'Order',
      style: AppStyle().titleLarge,
    ),
  );
}

Widget cateringOrderBody(BuildContext context,
    {required CateringOrderController controller}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
    child: Obx(
      () => FutureBuilder(
        future: controller.futureOrder(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List snapData = snapshot.data! as List;

            if (snapData[0] != 404) {
              return ReListView(
                itemCount: snapData[2].length,
                itemBuilder: (context, index) {
                  var menuList = snapData[2][index]['menu_order_dipesan'];
                  return ReElevation(
                    child: Card(
                      child: Theme(
                        data: Theme.of(context)
                            .copyWith(dividerColor: Colors.transparent),
                        child: ExpansionTile(
                          title: ReText(
                            value: '${snapData[2][index]['tanggal_menu']}',
                            style: AppStyle().titleMedium,
                          ),
                          children: List.generate(
                            menuList.length,
                            (indexItem) => Column(
                              children: [
                                if (indexItem == 0) const Divider(),
                                ListTile(
                                  leading: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ReText(
                                        value:
                                            '${menuList[indexItem]['nama_menu']}',
                                        style: AppStyle().bodyMedium,
                                      ),
                                      ReText(
                                        value: CurrencyFormat.toIdr(
                                            int.parse(menuList[indexItem]
                                                ['harga_menu']),
                                            0),
                                        style: AppStyle().bodySmall,
                                      ),
                                    ],
                                  ),
                                  trailing: TextButton(
                                    onPressed: () {
                                      Get.dialog(
                                        setPengantarDialog(
                                          context,
                                          controller: controller,
                                          idDetailOrder: menuList[indexItem]
                                              ['id_detail_order'],
                                        ),
                                        barrierDismissible: false,
                                      );
                                    },
                                    child: ReText(
                                      value: 'Set Pengantar',
                                      style: AppStyle().titleSmall.copyWith(
                                            color: AppColor.accent,
                                          ),
                                    ),
                                  ),
                                ),
                                if (indexItem < menuList.length - 1)
                                  const Divider(),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            } else {
              return Center(
                child: ReText(
                  value: 'No Data',
                  style: AppStyle().titleMedium,
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

Widget setPengantarDialog(BuildContext context,
    {required CateringOrderController controller,
    required String idDetailOrder}) {
  var idPengantar = '';
  return ReActionDialog(
    childrenAlignment: CrossAxisAlignment.center,
    onCancel: () {
      Get.back();
    },
    onConfirm: () {
      controller.setPengantar(
        idDetailOrder: idDetailOrder,
        idPengantar: idPengantar,
      );
    },
    title: 'Set Pengantar',
    children: [
      ReText(
        value: 'Pilih Pengantar',
        style: AppStyle().titleMedium.copyWith(color: AppColor.accent),
      ),
      const SizedBox(
        height: 8,
      ),
      DropdownMenu(
        width: Get.width * 0.6,
        dropdownMenuEntries: List.generate(
          controller.listPengantar.length,
          (index) => DropdownMenuEntry(
            value: controller.listPengantar[index][0],
            label: controller.listPengantar[index][1],
          ),
        ),
        onSelected: (value) {
          idPengantar = value;
        },
      ),
    ],
  );
}
