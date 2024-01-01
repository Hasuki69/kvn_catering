import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:kvn_catering/app/common/modules/delivery/delivery.controller.dart';
import 'package:kvn_catering/app/common/modules/gmap/gmap.view.dart';
import 'package:kvn_catering/app/common/widgets/custom_text.dart';
import 'package:kvn_catering/app/core/themes/style.dart';

import '../../widgets/custom_button.dart';

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
                    Row(
                      children: [
                        Expanded(
                          child: ReText(
                            value: "Detail Pengantaran",
                            style: AppStyle().titleLarge,
                          ),
                        ),
                        Wrap(
                          alignment: WrapAlignment.center,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            ReIconButton(
                              onPressed: () {
                                controller.openPhone(
                                    phone: Get.arguments['data']['nomer_telp']);
                              },
                              child: const Icon(
                                Icons.phone_outlined,
                              ),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            ReIconButton(
                              onPressed: () {
                                controller.openWhatsapp(
                                    phone: Get.arguments['data']['nomer_telp']);
                              },
                              child: const FaIcon(
                                FontAwesomeIcons.whatsapp,
                              ),
                            ),
                          ],
                        ),
                      ],
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
