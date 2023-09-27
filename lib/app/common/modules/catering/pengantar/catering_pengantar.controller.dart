import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kvn_catering/app/common/services/remote/pengantar.service.dart';
import 'package:kvn_catering/app/core/utils/extensions/loading_func.dart';

class CateringPengantarController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getPengantar();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    disposeForm();
  }

  // ==================== VARIABLE ====================
  GetStorage box = GetStorage();
  PengantarService pengantarService = PengantarService();

  var futurePengantar = Future.value().obs;

  final tecNama = TextEditingController();
  final tecTelp = TextEditingController();
  final tecEmail = TextEditingController();
  final tecUsername = TextEditingController();
  final tecPassword = TextEditingController();

  var isVisible = true.obs;

  // ==================== FUNCTION ====================
  get session => box.read('session') ?? false;
  get uid => box.read('uid') ?? '';
  get cateringUid => box.read('cateringUid') ?? '';
  get role => box.read('role') ?? 0;

  void passwordVisibility() {
    isVisible.value = !isVisible.value;
  }

  Future<void> getPengantar() async {
    futurePengantar = pengantarService.getPengantar(catUid: cateringUid).obs;
  }

  Future<void> refreshPengantar() async {
    futurePengantar.value = pengantarService.getPengantar(catUid: cateringUid);
  }

  void clearForm() {
    tecNama.clear();
    tecTelp.clear();
    tecEmail.clear();
    tecUsername.clear();
    tecPassword.clear();
  }

  void disposeForm() {
    tecNama.dispose();
    tecTelp.dispose();
    tecEmail.dispose();
    tecUsername.dispose();
    tecPassword.dispose();
  }

  Future<void> postPengantar() async {
    var status = '3';
    if (tecNama.text == '' ||
        tecTelp.text == '' ||
        tecEmail.text == '' ||
        tecUsername.text == '' ||
        tecPassword.text == '') {
      Get.snackbar("Error", "Please fill all field");
    } else {
      getLoading();
      var response = await pengantarService
          .createPengantar(
              catUid: cateringUid,
              nama: tecNama.text,
              telp: tecTelp.text,
              email: tecEmail.text,
              username: tecUsername.text,
              password: tecPassword.text,
              status: status)
          .whenComplete(() => closeLoading());

      if (response[0] == 200) {
        Get.back();
        clearForm();
        refreshPengantar();
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
}
