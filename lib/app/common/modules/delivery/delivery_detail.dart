import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:kvn_catering/app/common/modules/delivery/delivery.controller.dart';
import 'package:kvn_catering/app/common/modules/gmap/gmap.view.dart';
import 'package:kvn_catering/app/common/widgets/custom_text.dart';
import 'package:kvn_catering/app/core/themes/style.dart';

class DeliveryDetailView extends GetView<DeliveryController> {
  const DeliveryDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      extendBody: true,
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: Stack(
          children: [
            const GmapView(
              isDriver: true,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Card(
                margin: const EdgeInsets.all(0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: ReText(
                        value: "Detail Pengantaran",
                        style: AppStyle().titleLarge,
                      ),
                    ),
                    const Divider(),
                    Row(
                      children: [
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ReText(value: "Pemesan"),
                              ReText(value: "Alamat Pengiriman"),
                              Divider(),
                              ReText(value: "Detail Pesanan: "),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ReText(
                                  value:
                                      ": ${Get.arguments['data']['nama_pemesan']}"),
                              ReText(
                                  value:
                                      ": ${Get.arguments['data']['alamat']}"),
                              const Divider(),
                              const ReText(value: ""),
                            ],
                          ),
                        ),
                      ],
                    ),
                    ReText(
                      value:
                          "${Get.arguments['data']['nama_menu']} dengan harga Rp. ${Get.arguments['data']['harga_menu']}",
                      style: AppStyle().bodyLarge,
                    ),
                  ],
                ).paddingAll(16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
