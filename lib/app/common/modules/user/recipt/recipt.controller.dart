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
    getRecipt();
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
  get role => box.read('role') ?? 0;

  Future<void> getRecipt() async {
    futureRecipt = reciptService.getRecipt(uid: uid).obs;
  }

  Future<void> getReciptDetail({required String orderUid}) async {
    futureReciptDetail = reciptService.getReciptDetail(orderUid: orderUid).obs;
  }

  Future<void> callDatePicker(BuildContext context) async {
    await datePicker(context, selected: selectedDate).then((value) {
      selectedDate = value;
    });

    selectedDate1.value = DateFormat('dd-MM-yyyy').format(selectedDate);
  }
}
