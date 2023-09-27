import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:kvn_catering/app/common/services/remote/recipt.service.dart';
import 'package:kvn_catering/app/core/utils/extensions/datepicker_func.dart';

class ReciptController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getRecipt(tanggal: '');
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  // ==================== VARIABLES ====================
  GetStorage box = GetStorage();
  ReciptService reciptService = ReciptService();

  var selectedDate = DateTime.now();
  var selectedDate1 = DateFormat('dd-MM-yyyy').format(DateTime.now()).obs;

  var futureRecipt = Future.value().obs;
  var futureReciptDetail = Future.value().obs;

  // ==================== FUCTIONS ====================
  get session => box.read('session') ?? false;
  get uid => box.read('uid') ?? '';
  get cateringUid => box.read('cateringUid') ?? '';
  get role => box.read('role') ?? 0;

  Future<void> getRecipt({required String tanggal}) async {
    futureRecipt = reciptService
        .getRecipt(
          uid: uid,
          tanggal: tanggal,
        )
        .obs;
  }

  Future<void> reloadRecipt({required String tanggal}) async {
    futureRecipt.value = reciptService.getRecipt(
      uid: uid,
      tanggal: tanggal,
    );
  }

  Future<void> getReciptDetail({required String orderUid}) async {
    futureReciptDetail = reciptService.getReciptDetail(orderUid: orderUid).obs;
  }

  Future<void> callDatePicker(BuildContext context) async {
    await datePicker(context, selected: selectedDate).then((value) {
      selectedDate = value;
    });

    selectedDate1.value = DateFormat('dd-MM-yyyy').format(selectedDate);
    reloadRecipt(tanggal: selectedDate1());
  }
}
