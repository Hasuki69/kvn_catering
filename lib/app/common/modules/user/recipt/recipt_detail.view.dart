import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kvn_catering/app/common/modules/user/recipt/recipt.controller.dart';
import 'package:kvn_catering/app/common/widgets/custom_elevation.dart';
import 'package:kvn_catering/app/common/widgets/custom_listview.dart';
import 'package:kvn_catering/app/common/widgets/custom_text.dart';
import 'package:kvn_catering/app/core/configs/const.dart';
import 'package:kvn_catering/app/core/themes/theme.dart';
import 'package:kvn_catering/app/core/utils/extensions/string_currency.dart';

class ReciptDetailView extends GetView<ReciptController> {
  const ReciptDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: reciptDetailAppbar(context, controller: controller),
      body: SingleChildScrollView(
        controller: ScrollController(),
        child: reciptDetailBody(context, controller: controller),
      ),
    );
  }
}

PreferredSizeWidget reciptDetailAppbar(BuildContext context,
    {required ReciptController controller}) {
  return AppBar(
    centerTitle: true,
    forceMaterialTransparency: true,
    title: ReText(
      value: 'Recipt Detail',
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

Widget reciptDetailBody(BuildContext context,
    {required ReciptController controller}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
    child: FutureBuilder(
      future: controller.futureReciptDetail(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List snapData = snapshot.data! as List;
          if (snapData[0] != 404) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: ReText(
                        value: 'Nama Catering   ',
                        style: AppStyle().titleMedium,
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: ReText(
                        value: ':   ${snapData[2][0]['nama_catering']}',
                        style: AppStyle().bodyLarge,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: ReText(
                        value: 'Alamat   ',
                        style: AppStyle().titleMedium,
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: ReText(
                        value: ':   ${snapData[2][0]['alamat_catering']}',
                        style: AppStyle().bodyLarge,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: ReText(
                        value: 'Total   ',
                        style: AppStyle().titleMedium,
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: ReText(
                        value:
                            ':   ${CurrencyFormat.toIdr(snapData[2][0]['total'], 0)}',
                        style: AppStyle().bodyLarge,
                      ),
                    ),
                  ],
                ),
                const Divider(
                  height: 32,
                  color: AppColor.accent,
                ),
                ReText(
                  value: 'Daftar Menu: ',
                  style: AppStyle().titleMedium.copyWith(fontSize: 20),
                ),
                const SizedBox(
                  height: 16,
                ),
                ReListView(
                  itemCount: snapData[2][0]['menu_order'].length,
                  itemBuilder: (context, indexItem) {
                    return ReElevation(
                      child: Card(
                        child: ListTile(
                          title: Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: ReText(
                                  value:
                                      '${snapData[2][0]['menu_order'][indexItem]['status_order']}',
                                  style: AppStyle().bodyMedium,
                                ),
                              ),
                              const SizedBox(
                                height: 56,
                                child: VerticalDivider(
                                  width: 16,
                                  color: AppColor.accent,
                                ),
                              ),
                              Expanded(
                                flex: 5,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ReText(
                                      value:
                                          '${snapData[2][0]['menu_order'][indexItem]['tanggal_menu']} [${snapData[2][0]['menu_order'][indexItem]['jam_pengiriman_awal']}-${snapData[2][0]['menu_order'][indexItem]['jam_pengiriman_akhir']}]',
                                      style: AppStyle().titleSmall,
                                    ),
                                    ReText(
                                      value:
                                          '${snapData[2][0]['menu_order'][indexItem]['nama_menu']}',
                                      maxLines: 3,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          trailing: ReText(
                            value:
                                '${snapData[2][0]['menu_order'][indexItem]['jumlah_menu']}x  ${CurrencyFormat.toIdr(snapData[2][0]['menu_order'][indexItem]['harga_menu'], 0)}',
                            style: AppStyle().titleMedium,
                          ),
                        ),
                      ),
                    );
                  },
                ),
                const Divider(
                  height: 32,
                  color: AppColor.accent,
                ),
                ReText(
                  value: 'Bukti Pembayaran: ',
                  style: AppStyle().titleMedium.copyWith(fontSize: 20),
                ),
                const SizedBox(
                  height: 16,
                ),
                if (snapData[2][0]['foto_bukti_pembayaran'] != "")
                  Center(
                    child: SizedBox(
                      width: Get.width * 0.8,
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
                          '$apiImagePath${snapData[2][0]['foto_bukti_pembayaran']}',
                        ),
                      ),
                    ),
                  ),
              ],
            );
          } else {
            return Center(
              child: ReText(
                value: 'Data tidak ditemukan',
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
  );
}
