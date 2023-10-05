import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:kvn_catering/app/common/modules/gmap/gmap.controller.dart';
import 'package:kvn_catering/app/common/services/remote/order.service.dart';
import 'package:kvn_catering/app/core/utils/extensions/datepicker_func.dart';
import 'package:kvn_catering/app/core/utils/extensions/loading_func.dart';
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

  var rating = 0.obs;

  var futureOrder = Future.value().obs;
  var futureOrderDetail = Future.value().obs;

  var selectedDate = DateTime.now();
  var selectedDate1 = DateFormat('dd-MM-yyyy').format(DateTime.now()).obs;

  final reviewController = TextEditingController();

  final mapController = Get.find<GmapController>();

  Timer? timer;

  // ==================== FUCTIONS ====================
  get session => box.read('session') ?? false;
  get uid => box.read('uid') ?? '';
  get cateringUid => box.read('cateringUid') ?? '';
  get pengantarUid => box.read('pengantarUid') ?? '';
  get role => box.read('role') ?? 0;

  Future<void> callDatePicker(BuildContext context) async {
    await datePicker(context, selected: selectedDate).then((value) {
      selectedDate = value;
    });

    selectedDate1.value = DateFormat('dd-MM-yyyy').format(selectedDate);
  }

  Future<void> getOrder({required String date}) async {
    if (!Get.arguments['isHistory']) {
      futureOrder = orderService.getOrder(uid: uid, date: date).obs;
    } else {
      futureOrder = orderService.getHistory(uid: uid, date: date).obs;
    }
  }

  Future<void> updateOrder({required String date}) async {
    if (!Get.arguments['isHistory']) {
      futureOrder.value = orderService.getOrder(uid: uid, date: date);
    } else {
      futureOrder.value = orderService.getHistory(uid: uid, date: date);
    }
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

  Future<void> postRating(
      {required String uidDetailOrder, required String idCatering}) async {
    var response = await orderService
        .postRating(
            uidDetailOrder: uidDetailOrder,
            idCatering: idCatering,
            rating: rating().toString(),
            review: reviewController.text)
        .whenComplete(() => closeLoading());
    clearTEC();
    if (response[0] == 200) {
      updateOrder(date: selectedDate1());
      getOrder(date: selectedDate1());
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

  void clearTEC() {
    reviewController.clear();
  }

  void disposeTEC() {
    reviewController.dispose();
  }

  Future<void> getDriverLocation({required String uidPengantar}) async {
    var response =
        await orderService.getPengantarLocation(uidPengantar: uidPengantar);
    if (response[0] == 200) {
      timer = Timer.periodic(const Duration(seconds: 2), (timer) {
        mapController.setDriverLocation(
          LatLng(
            double.parse(response[2][0]['langtitude'].toString()),
            double.parse(response[2][0]['longtitude'].toString()),
          ),
        );
        debugPrint('Fetch Map...');
      });
    }
  }
}
