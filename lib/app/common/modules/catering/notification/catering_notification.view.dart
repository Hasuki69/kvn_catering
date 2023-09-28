import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kvn_catering/app/common/modules/catering/notification/catering_notification.controller.dart';
import 'package:kvn_catering/app/common/widgets/custom_elevation.dart';
import 'package:kvn_catering/app/common/widgets/custom_listview.dart';
import 'package:kvn_catering/app/common/widgets/custom_text.dart';
import 'package:kvn_catering/app/core/themes/theme.dart';

class CateringNotificationView extends GetView<CateringNotificationController> {
  const CateringNotificationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: cateringNotificationAppbar(context, controller: controller),
      body: SingleChildScrollView(
        controller: ScrollController(),
        child: cateringNotificationBody(context, controller: controller),
      ),
    );
  }
}

PreferredSizeWidget cateringNotificationAppbar(BuildContext context,
    {required CateringNotificationController controller}) {
  return AppBar(
    title: ReText(
      value: 'Notification',
      style: AppStyle().titleLarge,
    ),
  );
}

Widget cateringNotificationBody(BuildContext context,
    {required CateringNotificationController controller}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
    child: Obx(
      () => FutureBuilder(
        future: controller.futureNotif(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List snapData = snapshot.data! as List;
            if (snapData[0] != 404) {
              return ReListView(
                itemCount: snapData[2].length,
                itemBuilder: (context, index) {
                  return ReElevation(
                    child: Card(
                      child: ListTile(
                        leading: Wrap(
                          alignment: WrapAlignment.center,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            ReText(
                              value: snapData[2][index]['id_order'],
                            ),
                            const SizedBox(
                              height: 24,
                              child: VerticalDivider(
                                color: AppColor.accent,
                              ),
                            ),
                          ],
                        ),
                        title: ReText(
                          value: snapData[2][index]['catatan'],
                          maxLines: 2,
                        ),
                        trailing: TextButton(
                          onPressed: () {
                            controller.getNotifDetail(
                                orderUid: snapData[2][index]['id_order']);
                            Get.toNamed('/catering/notification-detail',
                                parameters: {
                                  'orderUid': snapData[2][index]['id_order'],
                                });
                          },
                          child: ReText(
                            value: 'Detail',
                            style: AppStyle()
                                .titleSmall
                                .copyWith(color: AppColor.accent),
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
