import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kvn_catering/app/common/services/remote/profile.service.dart';
import 'package:kvn_catering/app/core/utils/extensions/loading_func.dart';

class UserProfileController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getProfile(uid: uid);
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    disposeTEC();
  }

  // ==================== VARIABLES ====================
  GetStorage box = GetStorage();

  ProfileService profileService = ProfileService();

  var futureProfile = Future.value().obs;
  var isReadOnly = true.obs;

  final ctrlName = TextEditingController();
  final ctrlEmail = TextEditingController();
  final ctrlPhone = TextEditingController();

  // ==================== FUCTIONS ====================

  get session => box.read('session') ?? false;
  get uid => box.read('uid') ?? '';
  get cateringUid => box.read('cateringUid') ?? '';
  get role => box.read('role') ?? 0;

  Future<void> getProfile({required String uid}) async {
    futureProfile = profileService.getProfile(uid: uid).obs;
  }

  void setControllerValue(var data) {
    ctrlName.text = data[2][0]['nama_user'];
    ctrlEmail.text = data[2][0]['email_user'];
    ctrlPhone.text = data[2][0]['telp_user'];
  }

  void disposeTEC() {
    ctrlName.dispose();
    ctrlEmail.dispose();
    ctrlPhone.dispose();
  }

  void setReadOnly() {
    isReadOnly.value = !isReadOnly.value;
  }

  Future<void> updateProfile() async {
    getLoading();
    var response = await profileService
        .updateProfile(
            uid: uid,
            name: ctrlName.text,
            email: ctrlEmail.text,
            phone: ctrlPhone.text)
        .whenComplete(() => closeLoading());

    if (response[0] == 200) {
      setReadOnly();
      getProfile(uid: uid);
      Get.snackbar(
        response[1],
        'Profile Updated',
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
