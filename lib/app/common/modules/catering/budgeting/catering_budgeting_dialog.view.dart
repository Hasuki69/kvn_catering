import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kvn_catering/app/common/modules/catering/budgeting/catering_budgeting.controller.dart';
import 'package:kvn_catering/app/common/widgets/custom_dialog.dart';
import 'package:kvn_catering/app/common/widgets/custom_elevation.dart';
import 'package:kvn_catering/app/common/widgets/custom_listview.dart';
import 'package:kvn_catering/app/common/widgets/custom_text.dart';
import 'package:kvn_catering/app/core/themes/theme.dart';
import 'package:kvn_catering/app/core/utils/extensions/string_currency.dart';

Widget bahanDialog(
  BuildContext context, {
  required CateringBudgetingController controller,
  bool isRealisasi = false,
  String uidBahan = '',
  String uidBudget = '',
}) {
  return ReActionDialog(
    onCancel: () {
      controller.clearFormBahan();
      Get.back();
    },
    onConfirm: () {
      if (!isRealisasi) {
        controller.addtoListBahan();
      } else {
        controller.postRealisasi(uidBahan: uidBahan, budgetUid: uidBudget);
      }
    },
    title: !isRealisasi ? 'Tambah Bahan' : 'Realisasi Bahan',
    children: [
      ReText(
        value: !isRealisasi ? 'Nama Bahan' : 'Keterangan Bahan',
        style: AppStyle().titleMedium.copyWith(color: AppColor.accent),
      ),
      const SizedBox(
        width: 8,
      ),
      ReTextField(
        controller: controller.tecNamaBahan,
      ),
      const SizedBox(
        width: 8,
      ),
      Row(
        children: [
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ReText(
                  value: 'Jumlah Bahan',
                  style:
                      AppStyle().titleMedium.copyWith(color: AppColor.accent),
                ),
                const SizedBox(
                  width: 8,
                ),
                ReTextField(
                  keyboardType: TextInputType.number,
                  controller: controller.tecJumlahBahan,
                ),
              ],
            ),
          ),
          if (!isRealisasi)
            Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ReText(
                    value: 'Satuan',
                    style:
                        AppStyle().titleMedium.copyWith(color: AppColor.accent),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  ReTextField(
                    hintText: 'Kg, Gram, Liter, dll',
                    controller: controller.tecSatuanBahan,
                  ),
                ],
              ),
            ),
        ],
      ),
      const SizedBox(
        width: 8,
      ),
      ReText(
        value: !isRealisasi ? 'Budget Bahan' : 'Harga Bahan',
        style: AppStyle().titleMedium.copyWith(color: AppColor.accent),
      ),
      const SizedBox(
        width: 8,
      ),
      ReTextField(
        keyboardType: TextInputType.number,
        controller: controller.tecBudgetBahan,
      ),
    ],
  );
}

Widget bahanListDialog(
  BuildContext context, {
  required CateringBudgetingController controller,
  required String title,
  required Future future,
}) {
  return ReDialog(
    title: title,
    children: [
      FutureBuilder(
        future: future,
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
                        dense: true,
                        title: ReText(
                          value: snapData[2][index]['keterangan'],
                        ),
                        trailing: Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            ReText(
                                value:
                                    '${snapData[2][index]['jumlah_bahan']} x',
                                style: AppStyle().bodySmall),
                            ReText(
                              value: CurrencyFormat.toIdr(
                                  snapData[2][index]['harga_bahan'], 0),
                            ),
                          ],
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
    ],
    onCancel: () => Get.back(),
  );
}
