import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kvn_catering/app/common/modules/user/catering/catering_list.controller.dart';
import 'package:kvn_catering/app/common/widgets/custom_button.dart';
import 'package:kvn_catering/app/common/widgets/custom_elevation.dart';
import 'package:kvn_catering/app/common/widgets/custom_listview.dart';
import 'package:kvn_catering/app/common/widgets/custom_text.dart';
import 'package:kvn_catering/app/core/configs/const.dart';
import 'package:kvn_catering/app/core/themes/theme.dart';
import 'package:kvn_catering/app/core/utils/extensions/string_currency.dart';

class PembayaranCateringView extends GetView<CateringListController> {
  const PembayaranCateringView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: pembayaranAppbar(context, controller: controller),
      body: SingleChildScrollView(
        controller: ScrollController(),
        child: cateringListBody(
          context,
          controller: controller,
        ),
      ),
    );
  }
}

PreferredSizeWidget pembayaranAppbar(BuildContext context,
    {required CateringListController controller}) {
  return AppBar(
    centerTitle: true,
    forceMaterialTransparency: true,
    title: ReText(
      value: 'Pembayaran',
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

Widget cateringListBody(BuildContext context,
    {required CateringListController controller}) {
  return Padding(
    padding: const EdgeInsets.symmetric(
      horizontal: 24,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 24,
        ),
        ReText(
          value: 'Input alamat pengiriman:',
          style: AppStyle().titleMedium,
        ),
        const SizedBox(
          height: 8,
        ),
        ReTextField(
          hintText: 'Masukkan alamat',
          controller: controller.ctrlAlamat,
        ),
        const SizedBox(
          height: 8,
        ),
        ReText(
          value: 'Menu yang dipesan:',
          style: AppStyle().titleMedium,
        ),
        const SizedBox(
          height: 8,
        ),
        ReListView(
          itemCount: controller.selectedMenu()[0].length,
          itemBuilder: (context, index) {
            return ReElevation(
              child: Card(
                child: ListTile(
                  title: ReText(
                    value: controller.selectedMenu()[0][index],
                  ),
                  trailing: ReText(
                    value:
                        '${controller.selectedMenu()[1][index]}x ${CurrencyFormat.toIdr(controller.selectedMenu()[2][index], 0)}',
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
          value: 'Pembayaran: ',
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
          child: Column(
            children: [
              ReText(
                value:
                    'Total: ${CurrencyFormat.toIdr(controller.getTotalPayment(), 0)}',
                style: AppStyle().titleLarge.copyWith(
                      fontSize: 32,
                    ),
              ),
              const SizedBox(
                width: 24,
              ),
              ReText(
                value:
                    'No Rekening: ${Get.arguments['catering-data']['telp_catering']}',
                style: AppStyle().titleSmall.copyWith(
                      fontSize: 16,
                    ),
              ),
              FutureBuilder(
                future: controller.futureQR(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List data = snapshot.data! as List;
                    if (data[0] != 404) {
                      return Image(
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
                          '$apiImagePath${data[2]['path_qr']}',
                        ),
                      );
                    }
                  } else {
                    return const Center(
                      child: ReText(
                        value: 'Failed to get QR Code',
                      ),
                    );
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
              const SizedBox(
                height: 24,
              ),
              Row(
                children: [
                  Expanded(
                    child: Obx(
                      () => ReText(
                        value: controller.imageFile(),
                      ),
                    ),
                  ),
                  ReElevatedButton(
                    onPressed: () {
                      controller.pickFile();
                    },
                    child: ReText(
                      value: 'Upload QR',
                      style: AppStyle()
                          .titleMedium
                          .copyWith(color: AppColor.onAccent),
                    ),
                  ),
                ],
              ),
            ],
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
                controller.inputOrder(
                    idCat: Get.arguments['catering-data']['id_catering']);
              },
              child: ReText(
                value: 'Bayar',
                style:
                    AppStyle().titleMedium.copyWith(color: AppColor.onAccent),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
