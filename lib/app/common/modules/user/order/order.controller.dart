import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:kvn_catering/app/common/services/remote/order.service.dart';
import 'package:kvn_catering/app/core/utils/extensions/datepicker_func.dart';
import 'package:url_launcher/url_launcher.dart';

class OrderController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getOrder(date: selectedDate1());
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    disposeTEC();
  }

  // ==================== VARIABLES ====================
  GetStorage box = GetStorage();
  OrderService orderService = OrderService();

  var futureOrder = Future.value().obs;
  var futureOrderDetail = Future.value().obs;

  var selectedDate = DateTime.now();
  var selectedDate1 = DateFormat('dd-MM-yyyy').format(DateTime.now()).obs;

  final reviewController = TextEditingController();

  // ==================== FUCTIONS ====================
  get session => box.read('session') ?? false;
  get uid => box.read('uid') ?? '';
  get cateringUid => box.read('cateringUid') ?? '';
  get role => box.read('role') ?? 0;

  Future<void> callDatePicker(BuildContext context) async {
    await datePicker(context, selected: selectedDate).then((value) {
      selectedDate = value;
    });

    selectedDate1.value = DateFormat('dd-MM-yyyy').format(selectedDate);
  }

  Future<void> getOrder({required String date}) async {
    futureOrder = orderService.getOrder(uid: uid, date: date).obs;
  }

  Future<void> getOrderDetail({required String orderDetailUid}) async {
    futureOrderDetail =
        orderService.getOrderDetail(orderDetailUid: orderDetailUid).obs;
  }

  Future<void> openPhone({required String phone}) async {
    final url = Uri.parse('tel:$phone');
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Tidak dapat membuka WhatsApp';
    }
  }

  Future<void> openWhatsapp({required String phone}) async {
    final url = Uri.parse('https://wa.me/$phone');
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Tidak dapat membuka WhatsApp';
    }
  }

  void clearTEC() {
    reviewController.clear();
  }

  void disposeTEC() {
    reviewController.dispose();
  }
}
