import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kvn_catering/app/common/modules/gmap/gmap.controller.dart';
import 'package:kvn_catering/app/common/services/local/location.service.dart';
import 'package:kvn_catering/app/common/services/remote/delivery.service.dart';
import 'package:kvn_catering/app/common/services/remote/order.service.dart';
import 'package:kvn_catering/app/core/utils/extensions/loading_func.dart';

class DeliveryController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    locationServices.locationPermission();
    getOrderList();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  // ==================== VARIABLES ====================
  GetStorage box = GetStorage();
  OrderService orderService = OrderService();
  LocationServices locationServices = LocationServices();

  final mapController = Get.find<GmapController>();

  // ==================== FUCTIONS ====================

  get session => box.read('session') ?? false;
  get uid => box.read('uid') ?? '';
  get cateringUid => box.read('cateringUid') ?? '';
  get pengantarUid => box.read('pengantarUid') ?? '';
  get role => box.read('role') ?? 0;

  var futureDelivery = Future.value().obs;

  void logout() {
    box.erase();
    Get.offAllNamed('/auth');
  }

  Future<void> getOrderList() async {
    futureDelivery =
        DeliveryService.getDelivery(uidPengantar: pengantarUid).obs;
  }

  Future<void> refreshOrderList() async {
    futureDelivery.value =
        DeliveryService.getDelivery(uidPengantar: pengantarUid);
  }

  Future<void> getPembeliLocation({required String uidDetailOrder}) async {
    var response =
        await orderService.getUserLocation(uidDetailOrder: uidDetailOrder);
    if (response[0] == 200) {
      mapController.setUserLocation(
        LatLng(
          double.parse(response[2][0]['langitude']),
          double.parse(response[2][0]['longitude']),
        ),
      );
    }
  }

  Future<void> confirmOrder({required String idDetailOrder}) async {
    var response = await orderService
        .confirmOrder(uid: pengantarUid, idDetailOrder: idDetailOrder)
        .whenComplete(() => closeLoading());
    if (response[0] == 200) {
      refreshOrderList();
      Get.back();
      Get.snackbar(
        'Status ${response[0]}',
        response[1],
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } else if (response[0] == 404) {
      Get.snackbar(
        'Status ${response[0]}',
        response[1],
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } else {
      Get.snackbar(
        'Status ${response[0]}',
        response[1],
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}
