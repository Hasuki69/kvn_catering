import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kvn_catering/app/common/modules/user/recipt/recipt.controller.dart';
import 'package:kvn_catering/app/common/widgets/custom_elevation.dart';
import 'package:kvn_catering/app/common/widgets/custom_listview.dart';
import 'package:kvn_catering/app/common/widgets/custom_text.dart';
import 'package:kvn_catering/app/core/themes/theme.dart';

class ReciptView extends GetView<ReciptController> {
  const ReciptView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: reciptAppbar(context, controller: controller),
      body: SingleChildScrollView(
        controller: ScrollController(),
        child: reciptBody(context, controller: controller),
      ),
    );
  }
}

PreferredSizeWidget reciptAppbar(BuildContext context,
    {required ReciptController controller}) {
  return AppBar(
    centerTitle: true,
    forceMaterialTransparency: true,
    title: ReText(
      value: 'Recipt',
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

Widget reciptBody(BuildContext context,
    {required ReciptController controller}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const SizedBox(
        height: 24,
      ),
      reciptBodyHeader(context, controller: controller),
      reciptBodyContent(context, controller: controller),
      const SizedBox(
        height: 24,
      ),
    ],
  );
}

Widget reciptBodyHeader(BuildContext context,
    {required ReciptController controller}) {
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

Widget reciptBodyContent(BuildContext context,
    {required ReciptController controller}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
    child: Obx(
      () => FutureBuilder(
        future: controller.futureRecipt(),
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
                        leading: ReText(
                            value: '${snapData[2][index]['tanggal_order']}',
                            style: AppStyle().titleMedium),
                        title: ReText(
                          value: '${snapData[2][index]['nama_catering']}',
                        ),
                        trailing: IconButton(
                          onPressed: () {
                            controller.getReciptDetail(
                                orderUid: snapData[2][index]['id_order']);
                            Get.toNamed('/user/recipt/detail');
                          },
                          icon: const Icon(
                            Icons.arrow_forward_ios,
                            size: 16,
                            color: AppColor.accent,
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
