import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kvn_catering/app/common/services/remote/catering_location.service.dart';
import 'package:kvn_catering/app/core/utils/extensions/loading_func.dart';

class CateringLocationController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    ctrlRadius.text = '100';
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    ctrlRadius.dispose();
  }

  // ==================== VARIABLE ====================
  GetStorage box = GetStorage();
  CatLocationServices catLocationServices = CatLocationServices();

  final ctrlRadius = TextEditingController();

  // ==================== FUNCTION ====================
  get session => box.read('session') ?? false;
  get uid => box.read('uid') ?? '';
  get cateringUid => box.read('cateringUid') ?? '';
  get role => box.read('role') ?? 0;

  Future setCateringLocation(
      {required String lat,
      required String long,
      required String radius}) async {
    getLoading();
    var response = await catLocationServices
        .setLocation(uidCat: cateringUid, lat: lat, long: long, radius: radius)
        .whenComplete(() => closeLoading());
    if (response[0] == 200) {
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
