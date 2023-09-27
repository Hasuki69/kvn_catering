import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kvn_catering/app/common/modules/gmap/gmap.controller.dart';
import 'package:kvn_catering/app/core/themes/theme.dart';

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

class GmapSetLocationView extends GetView {
  @override
  final GmapController controller = Get.put(GmapController());
  GmapSetLocationView({super.key});

  @override
  Widget build(BuildContext context) {
    return gmapSetLocationBody(context, controller: controller);
  }
}

Widget gmapSetLocationBody(BuildContext context,
    {required GmapController controller}) {
  return Obx(
    () => GoogleMap(
      initialCameraPosition: controller.initialCameraPosition(),
      onMapCreated: controller.setLocationOnMapCreated,
      zoomControlsEnabled: false,
      circles: {
        Circle(
          circleId: const CircleId('selected_location'),
          center: controller.selectedLocation(),
          radius: controller.selectedRadius(),
          strokeWidth: 1,
          strokeColor: AppColor.accent,
          fillColor: AppColor.accent.withOpacity(0.2),
        ),
      },
      markers: {
        controller.selectedMarker(),
      },
      onTap: (LatLng latLng) {
        controller.isMyLocation(false);
        controller.setSelectedLocation(latLng);
      },
    ),
  );
}
