import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kvn_catering/app/common/services/local/location.service.dart';

class UserController extends GetxController {
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
      'Semua Catering',
      'lib/assets/images/semua.png',
      'lib/assets/images/banner2.jpg',
    ],
    [
      'Rating Terbaik',
      'lib/assets/images/rating.png',
      'lib/assets/images/banner2.jpg',
    ],
    [
      'Favorit',
      'lib/assets/images/favorit.png',
      'lib/assets/images/banner2.jpg',
    ],
    [
      'Harian',
      'lib/assets/images/harian.png',
      'lib/assets/images/banner2.jpg',
    ],
    [
      'Mingguan',
      'lib/assets/images/mingguan.png',
      'lib/assets/images/banner2.jpg',
    ],
    [
      'Bulanan',
      'lib/assets/images/bulanan.png',
      'lib/assets/images/banner2.jpg',
    ],
  ].obs;

  var bannerItem = [
    'lib/assets/images/banner1.png',
    'lib/assets/images/banner2.jpg',
  ].obs;

  var bannerIndex = 0.obs;

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
