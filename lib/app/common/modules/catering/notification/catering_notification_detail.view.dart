import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kvn_catering/app/common/modules/catering/notification/catering_notification.controller.dart';
import 'package:kvn_catering/app/common/widgets/custom_button.dart';
import 'package:kvn_catering/app/common/widgets/custom_elevation.dart';
import 'package:kvn_catering/app/common/widgets/custom_listview.dart';
import 'package:kvn_catering/app/common/widgets/custom_text.dart';
import 'package:kvn_catering/app/core/configs/const.dart';
import 'package:kvn_catering/app/core/themes/theme.dart';
import 'package:kvn_catering/app/core/utils/extensions/string_currency.dart';

class CateringNotificationDetailView
    extends GetView<CateringNotificationController> {
  const CateringNotificationDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: cateringNotificationDetailAppbar(context, controller: controller),
      body: SingleChildScrollView(
        controller: ScrollController(),
        child: cateringNotificationDetailBody(context, controller: controller),
      ),
    );
  }
}

PreferredSizeWidget cateringNotificationDetailAppbar(BuildContext context,
    {required CateringNotificationController controller}) {
  return AppBar(
    title: ReText(
      value: 'Notification Detail',
      style: AppStyle().titleLarge,
    ),
  );
}

Widget cateringNotificationDetailBody(BuildContext context,
    {required CateringNotificationController controller}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
    child: Obx(
      () => FutureBuilder(
        future: controller.futureNotifDetail(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List snapData = snapshot.data! as List;
            if (snapData[0] != 404) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 24,
                  ),
                  ReText(
                    value: 'Menu yang dipesan:',
                    style: AppStyle().titleMedium,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  ReListView(
                    itemCount: snapData[2]['menu_order_notif'].length,
                    itemBuilder: (context, index) {
                      return ReElevation(
                        child: Card(
                          child: ListTile(
                            leading: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ReText(
                                  value:
                                      '${snapData[2]['menu_order_notif'][index]['tanggal_menu']}',
                                  style: AppStyle().titleSmall,
                                ),
                                ReText(
                                  value:
                                      '${snapData[2]['menu_order_notif'][index]['jam_pengiriman_awal']} - ${snapData[2]['menu_order_notif'][index]['jam_pengiriman_akhir']}',
                                  style: AppStyle().bodySmall,
                                ),
                              ],
                            ),
                            title: Wrap(
                              alignment: WrapAlignment.start,
                              crossAxisAlignment: WrapCrossAlignment.center,
                              children: [
                                const SizedBox(
                                  height: 32,
                                  child: VerticalDivider(
                                    color: AppColor.accent,
                                  ),
                                ),
                                ReText(
                                  value: snapData[2]['menu_order_notif'][index]
                                      ['nama_menu'],
                                  style: AppStyle().bodyLarge,
                                ),
                              ],
                            ),
                            trailing: ReText(
                              value:
                                  '${snapData[2]['menu_order_notif'][index]['jumlah_menu']}x ${CurrencyFormat.toIdr(snapData[2]['menu_order_notif'][index]['harga_menu'], 0)}',
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  ReText(
                    value: 'Bukti Pembayaran: ',
                    style: AppStyle().titleMedium,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Image(
                      fit: BoxFit.fitWidth,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) {
                          return child;
                        }
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      },
                      image: NetworkImage(
                        '$apiImagePath${snapData[2]['path_foto']}',
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ReElevatedButton(
                        onPressed: () {
                          controller.confirmPembayaran(
                              uidOrder: Get.parameters['orderUid']!);
                        },
                        child: ReText(
                          value: 'Konfirmasi',
                          style: AppStyle()
                              .titleMedium
                              .copyWith(color: AppColor.onAccent),
                        ),
                      ),
                    ],
                  ),
                ],
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
