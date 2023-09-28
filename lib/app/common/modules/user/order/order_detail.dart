import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kvn_catering/app/common/modules/gmap/gmap.controller.dart';
import 'package:kvn_catering/app/common/modules/gmap/gmap.view.dart';
import 'package:kvn_catering/app/common/modules/user/order/order.controller.dart';
import 'package:kvn_catering/app/common/widgets/custom_button.dart';
import 'package:kvn_catering/app/common/widgets/custom_text.dart';
import 'package:kvn_catering/app/core/themes/theme.dart';
import 'package:kvn_catering/app/core/utils/extensions/string_currency.dart';

class OrderDetailView extends GetView<OrderController> {
  const OrderDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      extendBody: true,
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: orderDetailBody(context, controller: controller),
      ),
    );
  }
}

Widget orderDetailBody(BuildContext context,
    {required OrderController controller}) {
  final size = MediaQuery.of(context).size;
  return Stack(
    children: [
      SizedBox(
        width: size.width,
        child: AspectRatio(
          aspectRatio: 3 / 4,
          child: GmapView(),
        ),
      ),
      Positioned(
        bottom: 0,
        child: orderDetailContent(context, controller: controller),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 44, horizontal: 16),
        child: ReIconButton(
          child: const Icon(
            Icons.arrow_back,
          ),
          onPressed: () => Get.back(),
        ),
      ),
    ],
  );
}

Widget orderDetailContent(BuildContext context,
    {required OrderController controller}) {
  final size = MediaQuery.of(context).size;
  final mapController = Get.find<GmapController>();
  return Container(
    width: size.width,
    height: size.height * 0.4,
    decoration: BoxDecoration(
      color: AppColor.background,
      borderRadius: const BorderRadius.vertical(
        top: Radius.circular(16),
      ),
      boxShadow: [
        BoxShadow(
          color: AppColor.netral.withOpacity(0.1),
          blurRadius: 8,
          offset: const Offset(0, -4),
        ),
      ],
    ),
    child: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: FutureBuilder(
          future: controller.futureOrderDetail(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List snapData = snapshot.data! as List;
              if (snapData[0] != 404) {
                mapController.driverLocation(
                  LatLng(
                    snapData[2][0]['langtitude'] == 0
                        ? snapData[2][0]['langtitude'].toDouble()
                        : snapData[2][0]['langtitude'],
                    snapData[2][0]['longtitude'] == 0
                        ? snapData[2][0]['langtitude'].toDouble()
                        : snapData[2][0]['langtitude'],
                  ),
                );
                return Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ReText(
                              value: 'Pengantar: ',
                              style: AppStyle().bodyLarge,
                            ),
                            ReText(
                              value: '${snapData[2][0]['nama_pengantar']}',
                              style: AppStyle().titleLarge,
                            ),
                          ],
                        ),
                        Wrap(
                          alignment: WrapAlignment.center,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            ReIconButton(
                              onPressed: () {
                                controller.openPhone(
                                    phone: snapData[2][0]['nomer_telp']);
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
                                    phone: snapData[2][0]['nomer_telp']);
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
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 24),
                      child: ReText(
                        value: snapData[2][0]['nama_catering'],
                        style: AppStyle().headingSmall,
                      ),
                    ),
                    ListTile(
                      title: ReText(
                        value: '${snapData[2][0]['nama_menu']}',
                        style: AppStyle().titleMedium,
                        maxLines: 3,
                      ),
                      subtitle: ReText(
                        value: 'Status: ${snapData[2][0]['status']}',
                        style: AppStyle().captionMedium,
                      ),
                      trailing: Wrap(
                        alignment: WrapAlignment.center,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          ReText(
                            value: 'x${snapData[2][0]['jumlah']}',
                            style: AppStyle().bodyMedium,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 32, vertical: 2),
                          ),
                          ReText(
                            value: CurrencyFormat.toIdr(
                                snapData[2][0]['harga'], 0),
                            style: AppStyle().titleMedium,
                            maxLines: 3,
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              } else {
                return Center(
                  child: ReText(
                    value: 'No Data Found!',
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
    ),
  );
}
