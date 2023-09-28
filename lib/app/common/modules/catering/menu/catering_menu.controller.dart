import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:kvn_catering/app/common/services/remote/catering.service.dart';
import 'package:kvn_catering/app/core/utils/extensions/datepicker_func.dart';
import 'package:kvn_catering/app/core/utils/extensions/filepicker_func.dart';
import 'package:kvn_catering/app/core/utils/extensions/loading_func.dart';
import 'package:kvn_catering/app/core/utils/extensions/timepicker_func.dart';

class CateringMenuController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getCateringMenu(cateringUid: cateringUid);
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    disposeForm();
  }

  // ==================== VARIABLE ====================
  GetStorage box = GetStorage();
  CateringService cateringService = CateringService();

  var futureCateringMenu = Future.value().obs;

  var selectedDate = DateTime.now();
  var selectedDate1 = DateFormat('dd-MM-yyyy').format(DateTime.now()).obs;

  var currDate = DateTime.now();
  var currDate1 = DateFormat('dd-MM-yyyy').format(DateTime.now()).obs;

  var selectedTime = TimeOfDay.now();

  var imagePath = ''.obs;
  var imageFile = ''.obs;

  final tecNamaMenu = TextEditingController();
  final tecHarga = TextEditingController();
  final tecJamAwal = TextEditingController();
  final tecJamAkhir = TextEditingController();

  // ==================== FUNCTION ====================
  get session => box.read('session') ?? false;
  get uid => box.read('uid') ?? '';
  get cateringUid => box.read('cateringUid') ?? '';
  get role => box.read('role') ?? 0;

  Future<void> getCateringMenu({required String cateringUid}) async {
    futureCateringMenu = cateringService
        .getCateringMenu(
          cateringUid: cateringUid,
          dateFrom: selectedDate1(),
          dateTo: '',
        )
        .obs;
  }

  Future<void> updateCateringMenu({required String cateringUid}) async {
    futureCateringMenu.value = cateringService.getCateringMenu(
      cateringUid: cateringUid,
      dateFrom: selectedDate1(),
      dateTo: '',
    );
  }

  Future<void> callDatePicker(BuildContext context) async {
    await datePicker(context, selected: selectedDate).then((value) {
      selectedDate = value;
    });

    selectedDate1.value = DateFormat('dd-MM-yyyy').format(selectedDate);

    updateCateringMenu(cateringUid: cateringUid);
  }

  Future<void> pickFile() async {
    var result = await filePicker();
    if (result == null) {
      Get.snackbar("Error", "Please try again");
    } else {
      imagePath(result['path']);
      imageFile(result['name']);
    }
  }

  Future<String> callTimePicker(context, TimeOfDay selectedTime) async {
    await timePicker(context, selected: selectedTime).then((value) {
      selectedTime = value;
    });
    return selectedTime.format(context);
  }

  void clearForm() {
    imagePath('');
    imageFile('');
    tecNamaMenu.clear();
    tecHarga.clear();
    tecJamAwal.clear();
    tecJamAkhir.clear();
  }

  void disposeForm() {
    tecNamaMenu.dispose();
    tecHarga.dispose();
    tecJamAwal.dispose();
    tecJamAkhir.dispose();
  }

  Future<void> inputMenu() async {
    var status = '0';
    if (currDate1() == '' ||
        tecNamaMenu.text == '' ||
        tecHarga.text == '' ||
        tecJamAwal.text == '' ||
        tecJamAkhir.text == '' ||
        imagePath() == '') {
      Get.snackbar("Error", "Please fill all field");
    } else {
      getLoading();
      var response = await cateringService
          .catAddMenu(
              catUid: cateringUid,
              nama: tecNamaMenu.text,
              harga: tecHarga.text,
              tanggal: currDate1(),
              jamAwal: tecJamAwal.text,
              jamAkhir: tecJamAkhir.text,
              status: status,
              photo: imagePath())
          .whenComplete(() => closeLoading());

      if (response[0] == 200) {
        Get.back();
        clearForm();
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
      updateCateringMenu(cateringUid: cateringUid);
    }
  }

  void setController({required Map data}) {
    tecNamaMenu.text = data['nama_menu'];
    tecHarga.text = data['harga_menu'].toString();
    tecJamAwal.text = data['jam_pengiriman_awal'];
    tecJamAkhir.text = data['jam_pengiriman_akhir'];
  }

  Future<void> updateMenu({required String menuUid}) async {
    getLoading();
    var response = await cateringService
        .catUpdateMenu(
            catUid: cateringUid,
            menuUid: menuUid,
            namaMenu: tecNamaMenu.text,
            hargaMenu: tecHarga.text,
            jamAwal: tecJamAwal.text,
            jamAkhir: tecJamAkhir.text)
        .whenComplete(() => closeLoading());

    if (response[0] == 200) {
      Get.back();
      updateCateringMenu(cateringUid: cateringUid);
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
    clearForm();
  }
}
