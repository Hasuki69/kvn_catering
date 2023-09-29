import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kvn_catering/app/common/services/local/location.service.dart';

class CateringController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    locationServices.locationPermission();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  // ==================== VARIABLES ====================
  GetStorage box = GetStorage();
  LocationServices locationServices = LocationServices();

  var menuItem = [
    [
      'Menu',
      'lib/assets/images/menu.png',
      '/catering/menu',
    ],
    [
      'Set Lokasi',
      'lib/assets/images/lokasi.png',
      '/catering/location',
    ],
    [
      'Budgeting',
      'lib/assets/images/budgeting.png',
      '/catering/budgeting',
    ],
    [
      'Tambah Pengantar',
      'lib/assets/images/pengantar.png',
      '/catering/pengantar',
    ],
    [
      'Order',
      'lib/assets/images/order.png',
      '/catering/order',
    ],
  ].obs;

  // ==================== FUCTIONS ====================

  get session => box.read('session') ?? false;
  get uid => box.read('uid') ?? '';
  get cateringUid => box.read('cateringUid') ?? '';
  get pengantarUid => box.read('pengantarUid') ?? '';
  get role => box.read('role') ?? 0;

  void logout() {
    box.erase();
    Get.offAllNamed('/auth');
  }
}
