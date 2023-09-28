import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kvn_catering/app/common/modules/catering/budgeting/catering_budgeting.controller.dart';
import 'package:kvn_catering/app/common/widgets/custom_elevation.dart';
import 'package:kvn_catering/app/common/widgets/custom_listview.dart';
import 'package:kvn_catering/app/common/widgets/custom_text.dart';
import 'package:kvn_catering/app/core/themes/theme.dart';

class CateringBudgetingView extends GetView<CateringBudgetingController> {
  const CateringBudgetingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: budgetingAppbar(context, controller: controller),
      body: SingleChildScrollView(
        controller: ScrollController(),
        child: budgetingBody(context, controller: controller),
      ),
      floatingActionButton: budgetingFAB(context, controller: controller),
    );
  }
}

PreferredSizeWidget budgetingAppbar(BuildContext context,
    {required CateringBudgetingController controller}) {
  return AppBar(
    title: ReText(
      value: 'Budgeting',
      style: AppStyle().titleLarge,
    ),
  );
}

Widget budgetingBody(BuildContext context,
    {required CateringBudgetingController controller}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
    child: Obx(
      () => FutureBuilder(
        future: controller.futureBudgeting(),
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
                        title: ReText(
                          value: snapData[2][index]['id_menu'],
                        ),
                        trailing: IconButton(
                          onPressed: () {
                            controller.getBudgetingDetail(
                                budgetUid: snapData[2][index]['id_budgeting']);
                            Get.toNamed(
                              '/catering/budgeting/detail',
                            );
                          },
                          icon: const Icon(
                            Icons.arrow_forward,
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

Widget budgetingFAB(BuildContext context,
    {required CateringBudgetingController controller}) {
  return FloatingActionButton(
    backgroundColor: AppColor.accent,
    onPressed: () {
      Get.toNamed('/catering/budgeting/form')?.whenComplete(
        () => controller.clearForm(),
      );
    },
    child: const Icon(
      Icons.add,
      color: AppColor.primary,
    ),
  );
}
