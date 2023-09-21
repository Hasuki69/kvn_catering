import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kvn_catering/app/common/services/remote/profile.service.dart';
import 'package:kvn_catering/app/core/utils/extensions/loading_func.dart';
// import 'package:kvn_catering/app/core/utils/extensions/string_separator.dart';

class CateringProfileController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getCateringProfile(uid: uid);
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    disposeTEC();
  }

  // ==================== VARIABLE ====================
  GetStorage box = GetStorage();
  ProfileService profileService = ProfileService();

  var futureCateringProfile = Future.value().obs;
  var isReadOnly = true.obs;

  final ctrlName = TextEditingController();
  final ctrlEmail = TextEditingController();
  final ctrlPhone = TextEditingController();
  final ctrlAddress = TextEditingController();
  final ctrlDesc = TextEditingController();

/*
  var waktuPemesanan = <List<dynamic>>[
    ['Harian', false],
    ['Mingguan', false],
    ['Bulanan', false],
  ].obs;
*/

  // ==================== FUNCTION ====================
  get session => box.read('session') ?? false;
  get uid => box.read('uid') ?? '';
  get cateringUid => box.read('cateringUid') ?? '';
  get role => box.read('role') ?? 0;

  Future<void> getCateringProfile({required String uid}) async {
    futureCateringProfile = profileService.getCateringProfile(uid: uid).obs;
  }

  void setControllerValue(var data) {
    /*
    waktuPemesanan.value = <List<dynamic>>[
      ['Harian', false],
      ['Mingguan', false],
      ['Bulanan', false],
    ];
    */
    ctrlName.text = data[2][0]['nama_catering'];
    ctrlEmail.text = data[2][0]['email_catering'];
    ctrlPhone.text = data[2][0]['telp_catering'];
    ctrlAddress.text = data[2][0]['alamat_catering'];
    ctrlDesc.text = data[2][0]['deskripsi_catering'];
    /*
    for (var element in data[2][0]['tipe_pemesanan']) {
      if (element == 'Harian') {
        waktuPemesanan[0][1] = true;
      } else if (element == 'Mingguan') {
        waktuPemesanan[1][1] = true;
      } else if (element == 'Bulanan') {
        waktuPemesanan[2][1] = true;
      }
    }
    */
  }

  void disposeTEC() {
    ctrlName.dispose();
    ctrlEmail.dispose();
    ctrlPhone.dispose();
    ctrlAddress.dispose();
    ctrlDesc.dispose();
  }

  void setReadOnly() {
    isReadOnly.value = !isReadOnly.value;
  }

  Future<void> updateCateringProfile() async {
    getLoading();
    //String typePemesanan = addSeparator(waktuPemesanan, '|');
    var response = await profileService
        .updateCateringProfile(
            cateringUid: cateringUid,
            cateringName: ctrlName.text,
            cateringAddress: ctrlAddress.text,
            cateringPhone: ctrlPhone.text,
            cateringEmail: ctrlEmail.text,
            cateringDesc: ctrlDesc.text,
            //cateringType: typePemesanan,
            )
        .whenComplete(() => closeLoading());

    if (response[0] == 200) {
      setReadOnly();
      getCateringProfile(uid: uid);
      Get.snackbar(
        response[1],
        'Catering Profile Updated',
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
