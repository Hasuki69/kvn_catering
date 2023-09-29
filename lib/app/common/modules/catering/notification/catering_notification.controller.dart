import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kvn_catering/app/common/services/remote/notif.service.dart';
import 'package:kvn_catering/app/core/utils/extensions/loading_func.dart';

class CateringNotificationController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getNotif();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  // ==================== VARIABLE ====================
  GetStorage box = GetStorage();

  NotifService notifService = NotifService();

  var futureNotif = Future.value().obs;
  var futureNotifDetail = Future.value().obs;

  // ==================== FUNCTION ====================
  get session => box.read('session') ?? false;
  get uid => box.read('uid') ?? '';
  get cateringUid => box.read('cateringUid') ?? '';
  get pengantarUid => box.read('pengantarUid') ?? '';
  get role => box.read('role') ?? 0;

  Future<void> getNotif() async {
    futureNotif = notifService.getAllNotif(catUid: cateringUid).obs;
  }

  Future<void> updateCateringMenu() async {
    futureNotif.value = notifService.getAllNotif(catUid: cateringUid);
  }

  Future<void> getNotifDetail({required String orderUid}) async {
    futureNotifDetail = notifService.getDetailNotif(orderUid: orderUid).obs;
  }

  Future<void> confirmPembayaran({required String uidOrder}) async {
    getLoading();
    var response = await notifService
        .confirmPembayaran(orderUid: uidOrder)
        .whenComplete(() => closeLoading());

    if (response[0] == 200) {
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
