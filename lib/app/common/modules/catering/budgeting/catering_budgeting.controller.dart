import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:kvn_catering/app/common/services/remote/budgeting.service.dart';
import 'package:kvn_catering/app/common/services/remote/catering.service.dart';
import 'package:kvn_catering/app/core/utils/extensions/datepicker_func.dart';
import 'package:kvn_catering/app/core/utils/extensions/loading_func.dart';

class CateringBudgetingController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getBudgeting();
    getDropdownMasterMenu();
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
  var futureRealisasiBahan = Future.value().obs;

  final tecPorsi = TextEditingController();
  final tecTanggal = TextEditingController();
  var listBahan = [].obs;

  final tecNamaBahan = TextEditingController();
  final tecJumlahBahan = TextEditingController();
  final tecBudgetBahan = TextEditingController();
  final tecSatuanBahan = TextEditingController();

  var selectedDate = DateTime.now();
  var selectedDate1 = DateFormat('dd-MM-yyyy').format(DateTime.now()).obs;

  RxList dropdownMasterMenu = List.empty(growable: true).obs;
  String selectedMasterMenu = '';

  // ==================== FUNCTION ====================
  get session => box.read('session') ?? false;
  get uid => box.read('uid') ?? '';
  get cateringUid => box.read('cateringUid') ?? '';
  get role => box.read('role') ?? 0;

  Future<void> getDropdownMasterMenu() async {
    log("Fetch Dropdown Master Menu API", name: "Service");
    dropdownMasterMenu.clear();
    await CateringService()
        .getDropdownMasterMenu(idCatering: cateringUid)
        .then((value) {
      if (value[0] == 200) {
        for (var e in value[2]) {
          dropdownMasterMenu.add(
            [e['id_master_menu'], e['nama_menu']],
          );
        }
      }
    });
  }

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
    tecPorsi.dispose();
    tecTanggal.dispose();
    tecNamaBahan.dispose();
    tecJumlahBahan.dispose();
    tecBudgetBahan.dispose();
    tecSatuanBahan.dispose();
  }

  void getRealisasi(
      {required String idBudgeting, required String idMasterMenu}) {
    futureRealisasi.value = BudgetingService.getRealisasi(
        idBudgeting: idBudgeting, idMasterMenu: idMasterMenu);
  }

  void getRealisasiBahan(
      {required String idBudgeting, required String idBahan}) {
    futureRealisasiBahan.value = BudgetingService.getRealisasiBahan(
        idBudgeting: idBudgeting, idBahan: idBahan);
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
    if (selectedMasterMenu.isEmpty ||
        tecPorsi.text.isEmpty ||
        tecTanggal.text.isEmpty) {
      Get.snackbar("Error", "Please fill all field");
    } else {
      getLoading();
      var response = await BudgetingService.inputBudgeting(
        catUid: cateringUid,
        idMasterMenu: selectedMasterMenu,
        totalPorsi: tecPorsi.text,
        tanggal: tecTanggal.text,
      ).whenComplete(() => closeLoading());

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
      {required String uidBahan, required String idBudgeting}) async {
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
        harga: tecBudgetBahan.text,
        idBudgeting: idBudgeting,
      ).whenComplete(() => closeLoading());

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
