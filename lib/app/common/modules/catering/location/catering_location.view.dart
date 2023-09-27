import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kvn_catering/app/common/modules/catering/location/catering_location.controller.dart';
import 'package:kvn_catering/app/common/modules/gmap/gmap.controller.dart';
import 'package:kvn_catering/app/common/modules/gmap/gmap.view.dart';
import 'package:kvn_catering/app/common/widgets/custom_button.dart';
import 'package:kvn_catering/app/common/widgets/custom_text.dart';
import 'package:kvn_catering/app/core/themes/theme.dart';

class CateringLocationView extends GetView<CateringLocationController> {
  const CateringLocationView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      extendBody: true,
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: cateringLocationBody(context, controller: controller),
      ),
    );
  }
}

Widget cateringLocationBody(BuildContext context,
    {required CateringLocationController controller}) {
  final size = MediaQuery.of(context).size;
  return Stack(
    children: [
      SizedBox(
        width: size.width,
        child: AspectRatio(
          aspectRatio: 3 / 5.3,
          child: GmapSetLocationView(),
        ),
      ),
      Positioned(
        bottom: 0,
        child: cateringLocationDetail(context, controller: controller),
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

Widget cateringLocationDetail(BuildContext context,
    {required CateringLocationController controller}) {
  final size = MediaQuery.of(context).size;
  final mapController = Get.find<GmapController>();
  return Container(
    width: size.width,
    height: size.height * 0.2,
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
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: ReTextField(
                    controller: controller.ctrlRadius,
                    hintText: 'Radius (m)',
                  ),
                ),
                IconButton.filled(
                  style: IconButton.styleFrom(
                    backgroundColor: AppColor.accent,
                  ),
                  onPressed: () {
                    mapController.setRadius(
                      radius: double.parse(controller.ctrlRadius.text),
                    );
                  },
                  icon: const Icon(
                    Icons.check,
                    color: AppColor.primary,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 24,
            ),
            Row(
              children: [
                const SizedBox(
                  width: 24,
                ),
                Expanded(
                  child: ReElevatedButton(
                    child: ReText(
                      textAlign: TextAlign.center,
                      value: 'Use my current location',
                      style: AppStyle().titleSmall.copyWith(
                            color: AppColor.primary,
                          ),
                      maxLines: 2,
                    ),
                    onPressed: () {
                      mapController.isMyLocation(true);
                      mapController.co = 0;
                    },
                  ),
                ),
                const SizedBox(
                  width: 24,
                ),
                Expanded(
                  child: ReElevatedButton(
                    child: ReText(
                      textAlign: TextAlign.center,
                      value: 'Save Catering Location',
                      style: AppStyle().titleSmall.copyWith(
                            color: AppColor.primary,
                          ),
                      maxLines: 2,
                    ),
                    onPressed: () {
                      controller.setCateringLocation(
                          lat: mapController
                              .selectedLocation()
                              .latitude
                              .toString(),
                          long: mapController
                              .selectedLocation()
                              .longitude
                              .toString(),
                          radius: controller.ctrlRadius.text);
                    },
                  ),
                ),
                const SizedBox(
                  width: 24,
                ),
              ],
            )
          ],
        ),
      ),
    ),
  );
}
