import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:kvn_catering/app/common/services/remote/budgeting.service.dart';
import 'package:kvn_catering/app/core/utils/extensions/datepicker_func.dart';
import 'package:kvn_catering/app/core/utils/extensions/loading_func.dart';
import 'package:kvn_catering/app/core/utils/extensions/string_separator.dart';

class CateringBudgetingController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getBudgeting();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    disposeForm();
  }

  // ==================== VARIABLE ====================
  GetStorage box = GetStorage();
  var futureBudgeting = Future.value().obs;
  var futureBudgetingDetail = Future.value().obs;

  var futureRealisasi = Future.value().obs;

  final tecNamaMenu = TextEditingController();
  final tecPorsi = TextEditingController();
  final tecTanggal = TextEditingController();
  var listBahan = [].obs;

  final tecNamaBahan = TextEditingController();
  final tecJumlahBahan = TextEditingController();
  final tecBudgetBahan = TextEditingController();
  final tecSatuanBahan = TextEditingController();

  var selectedDate = DateTime.now();
  var selectedDate1 = DateFormat('dd-MM-yyyy').format(DateTime.now()).obs;

  // ==================== FUNCTION ====================
  get session => box.read('session') ?? false;
  get uid => box.read('uid') ?? '';
  get cateringUid => box.read('cateringUid') ?? '';
  get role => box.read('role') ?? 0;

  Future<void> callDatePicker(BuildContext context) async {
    await datePicker(context, selected: selectedDate).then((value) {
      selectedDate = value;
    });

    selectedDate1.value = DateFormat('dd-MM-yyyy').format(selectedDate);
    tecTanggal.text = selectedDate1.value;
  }

  void addtoListBahan() {
    if (tecNamaBahan.text.isEmpty ||
        tecJumlahBahan.text.isEmpty ||
        tecBudgetBahan.text.isEmpty ||
        tecSatuanBahan.text.isEmpty) {
      Get.snackbar('Gagal', 'Data tidak boleh kosong');
      return;
    }
    listBahan.add({
      'nama': tecNamaBahan.text,
      'jumlah': int.parse(tecJumlahBahan.text),
      'budget': int.parse(tecBudgetBahan.text),
      'satuan': tecSatuanBahan.text,
    });
    Get.back();
  }

  void removeItemAt(int index) {
    listBahan.removeAt(index);
  }

  void clearForm() {
    selectedDate = DateTime.now();
    selectedDate1 = DateFormat('dd-MM-yyyy').format(DateTime.now()).obs;
    tecNamaMenu.clear();
    tecPorsi.clear();
    tecTanggal.clear();
    listBahan.value = [];
  }

  void clearFormBahan() {
    tecNamaBahan.clear();
    tecJumlahBahan.clear();
    tecBudgetBahan.clear();
    tecSatuanBahan.clear();
  }

  void disposeForm() {
    tecNamaMenu.dispose();
    tecPorsi.dispose();
    tecTanggal.dispose();
    tecNamaBahan.dispose();
    tecJumlahBahan.dispose();
    tecBudgetBahan.dispose();
    tecSatuanBahan.dispose();
  }

  Future<void> getRealisasi({required String uidBahan}) async {
    futureRealisasi = BudgetingService.getRealisasi(uidBahan: uidBahan).obs;
  }

  Future<void> getBudgeting() async {
    futureBudgeting = BudgetingService.getBudgeting(catUid: cateringUid).obs;
  }

  Future<void> refreshBudgeting() async {
    futureBudgeting.value = BudgetingService.getBudgeting(catUid: cateringUid);
  }

  Future<void> getBudgetingDetail({required String budgetUid}) async {
    futureBudgetingDetail =
        BudgetingService.getDetailBudgeting(budgetUid: budgetUid).obs;
  }

  Future<void> refreshBudgetingDetail({required String budgetUid}) async {
    futureBudgetingDetail.value =
        BudgetingService.getDetailBudgeting(budgetUid: budgetUid);
  }

  Future<void> postBudgeting() async {
    if (tecNamaMenu.text.isEmpty ||
        tecPorsi.text.isEmpty ||
        tecTanggal.text.isEmpty ||
        listBahan.isEmpty) {
      Get.snackbar("Error", "Please fill all field");
    } else {
      getLoading();
      List tempNamaBahan = [];
      List tempJumlahBahan = [];
      List tempSatuanBahan = [];
      List tempHargaBahan = [];

      for (var i = 0; i < listBahan.length; i++) {
        tempNamaBahan.add(listBahan[i]['nama']);
        tempJumlahBahan.add(listBahan[i]['jumlah']);
        tempSatuanBahan.add(listBahan[i]['satuan']);
        tempHargaBahan.add(listBahan[i]['budget']);
      }
      var namaBahan = strSeparator(tempNamaBahan, '|');
      var jumlahBahan = strSeparator(tempJumlahBahan, '|');
      var satuanBahan = strSeparator(tempSatuanBahan, '|');
      var hargaBahan = strSeparator(tempHargaBahan, '|');

      var response = await BudgetingService.inputBudgeting(
              catUid: cateringUid,
              namaMenu: tecNamaMenu.text,
              totalPorsi: tecPorsi.text,
              tanggal: tecTanggal.text,
              namaBahan: namaBahan,
              jumlahBahan: jumlahBahan,
              satuanBahan: satuanBahan,
              hargaBahan: hargaBahan)
          .whenComplete(() => closeLoading());

      if (response[0] == 200) {
        refreshBudgeting();
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
    }
  }

  Future<void> postRealisasi(
      {required String uidBahan, required String budgetUid}) async {
    if (tecNamaBahan.text.isEmpty ||
        tecJumlahBahan.text.isEmpty ||
        tecBudgetBahan.text.isEmpty) {
      Get.snackbar("Error", "Please fill all field");
    } else {
      getLoading();
      var response = await BudgetingService.inputRealisasi(
              uidBahan: uidBahan,
              keterangan: tecNamaBahan.text,
              jumlah: tecJumlahBahan.text,
              harga: tecBudgetBahan.text)
          .whenComplete(() => closeLoading());

      if (response[0] == 200) {
        Get.back();
        clearFormBahan();
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
