import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:kvn_catering/app/common/modules/delivery/delivery.controller.dart';
import 'package:kvn_catering/app/common/modules/gmap/gmap.view.dart';

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
        child: GmapView(
          isDriver: true,
        ),
      ),
    );
  }
}
