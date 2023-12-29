import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kvn_catering/app/common/modules/catering/budgeting/catering_budgeting.controller.dart';
import 'package:kvn_catering/app/common/modules/catering/budgeting/catering_budgeting_dialog.view.dart';
import 'package:kvn_catering/app/common/widgets/custom_elevation.dart';
import 'package:kvn_catering/app/common/widgets/custom_listview.dart';
import 'package:kvn_catering/app/common/widgets/custom_text.dart';
import 'package:kvn_catering/app/core/themes/theme.dart';
import 'package:kvn_catering/app/core/utils/extensions/string_currency.dart';

class CateringBudgetingDetailView extends GetView<CateringBudgetingController> {
  const CateringBudgetingDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: budgetingDetailAppbar(context, controller: controller),
      body: SingleChildScrollView(
        controller: ScrollController(),
        child: budgetingDetailBody(context, controller: controller),
      ),
    );
  }
}

PreferredSizeWidget budgetingDetailAppbar(BuildContext context,
    {required CateringBudgetingController controller}) {
  return AppBar(
    title: ReText(
      value: 'Budgeting Detail',
      style: AppStyle().titleLarge,
    ),
  );
}

Widget budgetingDetailBody(BuildContext context,
    {required CateringBudgetingController controller}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
    child: Obx(
      () => FutureBuilder(
        future: controller.futureBudgetingDetail(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List snapData = snapshot.data! as List;
            if (snapData[0] != 404) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: ReText(
                          value: 'Tanggal',
                          style: AppStyle().titleMedium,
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: ReText(
                          value: ': ${snapData[2][0]['tanggal_budgeting']}',
                          style: AppStyle().titleMedium,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: ReText(
                          value: 'Nama',
                          style: AppStyle().titleMedium,
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: ReText(
                          value: ': ${snapData[2][0]['nama_menu']}',
                          style: AppStyle().titleMedium,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: ReText(
                          value: 'Porsi',
                          style: AppStyle().titleMedium,
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: ReText(
                          value: ': ${snapData[2][0]['total_porsi']}',
                          style: AppStyle().titleMedium,
                        ),
                      ),
                    ],
                  ),
                  const Divider(),
                  ReText(
                    value: 'Tabel budget: ',
                    style: AppStyle().titleMedium,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: AppColor.disable.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.all(16),
                    height: Get.height * 0.4,
                    child: ReListView(
                      physics: const ClampingScrollPhysics(),
                      itemCount: snapData[2][0]['bahan'].length,
                      itemBuilder: (context, index) {
                        var bahan = snapData[2][0]['bahan'];
                        return ReElevation(
                          child: Card(
                            child: ListTile(
                              dense: true,
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ReText(
                                    value: bahan[index]['nama_bahan'],
                                  ),
                                  ReText(
                                      value:
                                          '${bahan[index]['jumlah_bahan']} ${bahan[index]['satuan']}',
                                      style: AppStyle().bodySmall),
                                ],
                              ),
                              trailing: ReText(
                                value: CurrencyFormat.toIdr(
                                    bahan[index]['harga_bahan'], 0),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  ReText(
                    value: 'Tabel Realisasi: ',
                    style: AppStyle().titleMedium,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: AppColor.disable.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.all(16),
                    height: Get.height * 0.4,
                    child: ReListView(
                      physics: const ClampingScrollPhysics(),
                      itemCount: snapData[2][0]['bahan'].length,
                      itemBuilder: (context, index) {
                        var bahan = snapData[2][0]['bahan'];
                        return ReElevation(
                          child: Card(
                            child: ListTile(
                              dense: true,
                              title: ReText(
                                value: bahan[index]['nama_bahan'],
                              ),
                              trailing: Wrap(
                                crossAxisAlignment: WrapCrossAlignment.center,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      Get.dialog(
                                        bahanDialog(
                                          context,
                                          controller: controller,
                                          isRealisasi: true,
                                          uidBahan: bahan[index]['id_bahan'],
                                          idBudgeting: snapData[2][0]
                                              ['id_budgeting'],
                                        ),
                                      ).whenComplete(
                                        () => controller.clearFormBahan(),
                                      );
                                    },
                                    icon: const Icon(
                                      Icons.add,
                                      color: AppColor.accent,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      controller.getRealisasiBahan(
                                        idBudgeting: snapData[2][0]
                                            ['id_budgeting'],
                                        idBahan: bahan[index]['id_bahan'],
                                      );
                                      Get.dialog(
                                        bahanListDialog(
                                          context,
                                          controller: controller,
                                          title: bahan[index]['nama_bahan'],
                                          future:
                                              controller.futureRealisasiBahan(),
                                        ),
                                      );
                                    },
                                    icon: const Icon(
                                      Icons.arrow_forward,
                                      color: AppColor.accent,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
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
