import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kvn_catering/app/common/modules/delivery/delivery.controller.dart';
import 'package:kvn_catering/app/common/modules/delivery/delivery_sidebar.view.dart';
import 'package:kvn_catering/app/common/widgets/custom_elevation.dart';
import 'package:kvn_catering/app/common/widgets/custom_listview.dart';
import 'package:kvn_catering/app/common/widgets/custom_text.dart';
import 'package:kvn_catering/app/core/configs/const.dart';
import 'package:kvn_catering/app/core/themes/theme.dart';
import 'package:kvn_catering/app/core/utils/extensions/string_currency.dart';

class DeliveryView extends GetView<DeliveryController> {
  const DeliveryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: deliveryAppbar(context, controller: controller),
      endDrawer: deliverySidebar(context, controller: controller),
      body: SingleChildScrollView(
        controller: ScrollController(),
        child: deliveryBody(context, controller: controller),
      ),
    );
  }
}

PreferredSizeWidget deliveryAppbar(BuildContext context,
    {required DeliveryController controller}) {
  return AppBar(
    centerTitle: true,
    forceMaterialTransparency: true,
    title: SizedBox(
      width: 56,
      height: 56,
      child: Image.asset(appLogoIcon),
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

Widget deliveryBody(BuildContext context,
    {required DeliveryController controller}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        deliveryBodyContent(context, controller: controller),
      ],
    ),
  );
}

Widget deliveryBodyContent(BuildContext context,
    {required DeliveryController controller}) {
  return Obx(
    () => FutureBuilder(
      future: controller.futureDelivery(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List snapData = snapshot.data! as List;
          if (snapData[0] != 404) {
            return ReListView(
              itemCount: snapData[2].length,
              itemBuilder: (context, index) {
                var menuList = snapData[2][index]['menu_order_dipesan'] ?? [];
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                trailing: Wrap(
                                  children: [
                                    TextButton(
                                      onPressed: () {
                                        controller.confirmOrder(
                                            idDetailOrder: menuList[indexItem]
                                                ['id_detail_order']);
                                      },
                                      child: const Text(
                                        'Confirm',
                                        style: TextStyle(color: Colors.amber),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 16,
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        controller.getPembeliLocation(
                                            uidDetailOrder: menuList[indexItem]
                                                ['id_detail_order']);
                                        Get.toNamed('/delivery/detail')!
                                            .whenComplete(() {
                                          controller
                                              .mapController.streamSubscription!
                                              .cancel();
                                        });
                                      },
                                      icon: const Icon(
                                        Icons.arrow_forward_ios,
                                        color: AppColor.accent,
                                        size: 16,
                                      ),
                                    ),
                                  ],
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
  );
}
