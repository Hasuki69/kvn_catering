import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:kvn_catering/app/common/services/remote/catering.service.dart';
import 'package:kvn_catering/app/common/services/remote/order.service.dart';
import 'package:kvn_catering/app/core/utils/extensions/datepicker_func.dart';
import 'package:kvn_catering/app/core/utils/extensions/loading_func.dart';
import 'package:kvn_catering/app/core/utils/extensions/string_separator.dart';

class CateringListController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getCurrPos();
    getCateringList();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  // ==================== VARIABLES ====================
  GetStorage box = GetStorage();
  CateringService cateringService = CateringService();
  OrderService orderService = OrderService();

  var futureCateringList = Future.value().obs;
  var futureCateringMenu = Future.value().obs;

  var menuItem = [].obs;

  var selectedFilter = ''.obs;
  var selectedDate = DateTime.now();

  var selectedDate1 = DateFormat('dd-MM-yyyy').format(DateTime.now()).obs;
  var selectedDate2 = DateFormat('dd-MM-yyyy').format(DateTime.now()).obs;

  var catAddress = 'Catering Address'.obs;

  var currLocation = const LatLng(0.0, 0.0);

  // ==================== FUCTIONS ====================
  get session => box.read('session') ?? false;
  get uid => box.read('uid') ?? '';
  get role => box.read('role') ?? 0;

  Future getCurrPos() async {
    await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.bestForNavigation,
    ).then(
      (value) {
        currLocation = LatLng(value.latitude, value.longitude);
      },
    );
  }

  bool isInRange(LatLng start, double radius, context, setState) {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (context.mounted) setState(() {});
    });
    return Geolocator.distanceBetween(start.latitude, start.longitude,
            currLocation.latitude, currLocation.longitude) <=
        radius;
  }

  Future<void> getCateringList() async {
    futureCateringList = cateringService.getCatering().obs;
  }

  Future<void> getCateringMenu({required String cateringUid}) async {
    if (selectedFilter() == 'Mingguan' || selectedFilter() == 'Bulanan') {
      futureCateringMenu = cateringService
          .getCateringMenu(
            cateringUid: cateringUid,
            dateFrom: selectedDate1(),
            dateTo: selectedDate2(),
          )
          .obs;
    } else {
      futureCateringMenu = cateringService
          .getCateringMenu(
            cateringUid: cateringUid,
            dateFrom: selectedDate1(),
            dateTo: '',
          )
          .obs;
    }
  }

  Future<void> updateCateringMenu({required String cateringUid}) async {
    if (selectedFilter() == 'Mingguan' || selectedFilter() == 'Bulanan') {
      futureCateringMenu.value = cateringService.getCateringMenu(
        cateringUid: cateringUid,
        dateFrom: selectedDate1(),
        dateTo: selectedDate2(),
      );
    } else {
      futureCateringMenu.value = cateringService.getCateringMenu(
        cateringUid: cateringUid,
        dateFrom: selectedDate1(),
        dateTo: '',
      );
    }
  }

  void clearFilter() {
    selectedFilter.value = '';
    selectedDate1.value = DateFormat('dd-MM-yyyy').format(DateTime.now());
    selectedDate2.value = DateFormat('dd-MM-yyyy').format(DateTime.now());
  }

  void setSelectedDate() {
    if (selectedFilter() == 'Mingguan') {
      var inWeek = selectedDate.add(const Duration(days: 6));
      selectedDate2.value = DateFormat('dd-MM-yyyy').format(inWeek);
    } else if (selectedFilter() == 'Bulanan') {
      var lastDate = DateTime(selectedDate.year, selectedDate.month + 1, 0);
      var inMonth = selectedDate.add(Duration(days: lastDate.day));
      selectedDate2.value = DateFormat('dd-MM-yyyy').format(inMonth);
    }
    updateCateringMenu(
        cateringUid: Get.arguments['catering-data']['id_catering']);
  }

  Future<void> callDatePicker(BuildContext context) async {
    await datePicker(context, selected: selectedDate).then((value) {
      selectedDate = value;
    });

    selectedDate1.value = DateFormat('dd-MM-yyyy').format(selectedDate);

    if (selectedFilter() == 'Mingguan') {
      var inWeek = selectedDate.add(const Duration(days: 6));
      selectedDate2.value = DateFormat('dd-MM-yyyy').format(inWeek);
    } else if (selectedFilter() == 'Bulanan') {
      var lastDate = DateTime(selectedDate.year, selectedDate.month + 1, 0);
      var inMonth = selectedDate.add(Duration(days: lastDate.day));
      selectedDate2.value = DateFormat('dd-MM-yyyy').format(inMonth);
    }
    updateCateringMenu(
        cateringUid: Get.arguments['catering-data']['id_catering']);
  }

  Future<void> getAddress({required String lat, required String long}) async {
    catAddress.value =
        await cateringService.getCateringAddress(lat: lat, long: long);
  }

  Future<void> inputOrder({required String idCat}) async {
    getLoading();

    var date = DateTime.now();
    var formattedDate = DateFormat('dd-MM-yyyy').format(date);

    String idMenu = '';
    String namaMenu = '';
    String jumlahMenu = '';
    String hargaMenu = '';
    String tanggalMenu = '';

    List idMenuList = [];
    List namaMenuList = [];
    List jumlahMenuList = [];
    List hargaMenuList = [];
    List tanggalMenuList = [];

    for (var element in menuItem) {
      for (var data in element) {
        if (data[2] != 0) {
          idMenuList.add(data[0]);
          namaMenuList.add(data[1]);
          jumlahMenuList.add(data[2]);
          hargaMenuList.add(data[3]);
          tanggalMenuList.add(data[4]);
        }
      }
    }

    idMenu = strSeparator(idMenuList, '|');
    namaMenu = strSeparator(namaMenuList, '|');
    jumlahMenu = strSeparator(jumlahMenuList, '|');
    hargaMenu = strSeparator(hargaMenuList, '|');
    tanggalMenu = strSeparator(tanggalMenuList, '|');

    // print(uid);
    // print(idCat);
    // print(idMenu);
    // print(namaMenu);
    // print(jumlahMenu);
    // print(hargaMenu);
    // print(tanggalMenu);
    // print(formattedDate);
    // print(currLocation.latitude.toString());
    // print(currLocation.longitude.toString());

    var response = await orderService
        .inputOrder(
          uid: uid,
          idCat: idCat,
          idMenu: idMenu,
          namaMenu: namaMenu,
          jumlahMenu: jumlahMenu,
          hargaMenu: hargaMenu,
          tanggalMenu: tanggalMenu,
          tanggalOrder: formattedDate,
          lat: currLocation.latitude.toString(),
          long: currLocation.longitude.toString(),
        )
        .whenComplete(() => closeLoading());

    if (response[0] == 200) {
      Get.back();
      Get.back();

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
