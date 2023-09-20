import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kvn_catering/app/common/modules/gmap/gmap.controller.dart';

class GmapView extends GetView {
  @override
  final GmapController controller = Get.put(GmapController());
  GmapView({super.key});

  @override
  Widget build(BuildContext context) {
    return gmapBody(context, controller: controller);
  }
}

Widget gmapBody(BuildContext context, {required GmapController controller}) {
  return Obx(
    () => GoogleMap(
      initialCameraPosition: controller.initialCameraPosition(),
      onMapCreated: controller.onMapCreated,
      zoomControlsEnabled: false,
      markers: {
        controller.driverMarker(),
        controller.currentMarker(),
      },
    ),
  );
}
