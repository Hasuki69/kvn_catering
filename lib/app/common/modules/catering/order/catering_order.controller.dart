import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kvn_catering/app/common/services/remote/order.service.dart';
import 'package:kvn_catering/app/common/services/remote/pengantar.service.dart';
import 'package:kvn_catering/app/core/utils/extensions/loading_func.dart';

class CateringOrderController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getOrder();
    getPengantar();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  // ==================== VARIABLE ====================
  GetStorage box = GetStorage();
  PengantarService pengantarService = PengantarService();
  OrderService orderService = OrderService();

  var futureOrder = Future.value().obs;

  var listPengantar = [].obs;

  // ==================== FUNCTION ====================
  get session => box.read('session') ?? false;
  get uid => box.read('uid') ?? '';
  get cateringUid => box.read('cateringUid') ?? '';
  get role => box.read('role') ?? 0;

  Future<void> getPengantar() async {
    var response = await pengantarService.getPengantar(catUid: cateringUid);
    if (response[0] == 200) {
      response[2].forEach((element) {
        listPengantar.add([
          element['kode_pengantar'],
          element['nama_pengantar'],
        ]);
      });
    }
  }

  Future<void> getOrder() async {
    futureOrder = orderService.getOrder(uid: cateringUid, date: '').obs;
  }

  Future<void> refreshOrder({required String cateringUid}) async {
    futureOrder.value = orderService.getOrder(uid: cateringUid, date: '');
  }

  Future<void> setPengantar({
    required String idDetailOrder,
    required String idPengantar,
  }) async {
    getLoading();
    var response = await pengantarService
        .setPengantar(idDetailOrder: idDetailOrder, idPengantar: idPengantar)
        .whenComplete(() => closeLoading());

    if (response[0] == 200) {
      Get.back();
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
