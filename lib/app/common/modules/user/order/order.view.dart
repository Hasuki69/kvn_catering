import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:kvn_catering/app/common/modules/user/order/order.controller.dart';
import 'package:kvn_catering/app/common/widgets/custom_dialog.dart';
import 'package:kvn_catering/app/common/widgets/custom_elevation.dart';
import 'package:kvn_catering/app/common/widgets/custom_listview.dart';
import 'package:kvn_catering/app/common/widgets/custom_text.dart';
import 'package:kvn_catering/app/core/themes/theme.dart';
import 'package:kvn_catering/app/core/utils/extensions/string_currency.dart';

class OrderView extends GetView<OrderController> {
  const OrderView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: orderAppbar(context, controller: controller),
      body: SingleChildScrollView(
        controller: ScrollController(),
        child: orderBody(context, controller: controller),
      ),
    );
  }
}

PreferredSizeWidget orderAppbar(BuildContext context,
    {required OrderController controller}) {
  return AppBar(
    centerTitle: true,
    forceMaterialTransparency: true,
    title: ReText(
      value: Get.arguments['isHistory'] ? 'History List' : 'Order List',
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

Widget orderBody(BuildContext context, {required OrderController controller}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const SizedBox(
        height: 24,
      ),
      orderBodyHeader(context, controller: controller),
      orderBodyContent(context, controller: controller),
      const SizedBox(
        height: 24,
      ),
    ],
  );
}

Widget orderBodyHeader(BuildContext context,
    {required OrderController controller}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisSize: MainAxisSize.min,
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: GestureDetector(
          onTap: () {
            controller.callDatePicker(context);
          },
          child: Wrap(
            alignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              const Icon(
                Icons.calendar_today,
                color: AppColor.accent,
                size: 32,
              ),
              const SizedBox(
                width: 8,
              ),
              Obx(
                () => ReText(
                  value: controller.selectedDate1(),
                  style: AppStyle().titleMedium,
                ),
              ),
            ],
          ),
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

Widget orderBodyContent(BuildContext context,
    {required OrderController controller}) {
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
                  var menuList = !Get.arguments['isHistory']
                      ? snapData[2][index]['menu_order_dipesan']
                      : snapData[2][index]['history_order'];
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
                                    trailing: Column(
                                      children: [
                                        if (!Get.arguments['isHistory'])
                                          IconButton(
                                            onPressed: () {
                                              controller
                                                  .getOrderDetail(
                                                      orderDetailUid: menuList[
                                                              indexItem]
                                                          ['id_detail_order'])
                                                  .whenComplete(
                                                    () => Get.toNamed(
                                                        '/user/order/detail'),
                                                  );
                                            },
                                            icon: const Icon(
                                              Icons.arrow_forward_ios,
                                              color: AppColor.accent,
                                              size: 16,
                                            ),
                                          ),
                                        if (Get.arguments['isHistory'])
                                          Wrap(
                                            alignment: WrapAlignment.center,
                                            crossAxisAlignment:
                                                WrapCrossAlignment.center,
                                            children: [
                                              TextButton(
                                                onPressed: () {
                                                  Get.dialog(
                                                    ratingDialog(
                                                      context,
                                                      controller: controller,
                                                      orderDetailUid: menuList[
                                                              indexItem]
                                                          ['id_detail_order'],
                                                      idCatering:
                                                          menuList[indexItem]
                                                              ['id_catering'],
                                                    ),
                                                  );
                                                },
                                                child: ReText(
                                                  value: 'Rate & Review',
                                                  style: AppStyle()
                                                      .titleSmall
                                                      .copyWith(
                                                          color:
                                                              AppColor.accent),
                                                ),
                                              ),
                                              Wrap(
                                                alignment: WrapAlignment.center,
                                                crossAxisAlignment:
                                                    WrapCrossAlignment.center,
                                                children: [
                                                  const Icon(Icons.star,
                                                      color: AppColor.accent),
                                                  ReText(
                                                    value: menuList[indexItem]
                                                            ['rating']
                                                        .toString(),
                                                    style:
                                                        AppStyle().titleSmall,
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                      ],
                                    )),
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

Widget ratingDialog(BuildContext context,
    {required OrderController controller,
    required String orderDetailUid,
    required String idCatering}) {
  return ReActionDialog(
    title: 'Beri Penilaian',
    children: [
      ReText(
        value: 'Rating',
        style: AppStyle().titleMedium,
      ),
      RatingBar.builder(
        minRating: 1,
        direction: Axis.horizontal,
        itemCount: 5,
        itemPadding: const EdgeInsets.symmetric(horizontal: 4),
        glow: false,
        itemBuilder: (context, _) => const Icon(
          Icons.star,
          color: AppColor.accent,
        ),
        onRatingUpdate: (rating) {
          controller.rating(rating.toInt());
        },
      ),
      const SizedBox(
        height: 16,
      ),
      ReText(
        value: 'Review',
        style: AppStyle().titleMedium,
      ),
      ReTextField(
        controller: controller.reviewController,
        hintText: 'Tulis review',
        maxLines: 5,
      ),
    ],
    onCancel: () {
      controller.clearTEC();
      Get.back();
    },
    onConfirm: () {
      controller.postRating(
          uidDetailOrder: orderDetailUid, idCatering: idCatering);
    },
  );
}
