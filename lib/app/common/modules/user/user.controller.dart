import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:location/location.dart' as loc;
import 'package:permission_handler/permission_handler.dart';

class UserController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    locationPermission();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  // ==================== VARIABLES ====================
  GetStorage box = GetStorage();
  loc.Location location = loc.Location();

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
  get role => box.read('role') ?? 0;

  void logout() {
    box.erase();
    Get.offAllNamed('/auth');
  }

  Future<void> checkLocationAccess() async {
    var serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }
  }

  Future<void> locationPermission() async {
    final PermissionStatus status = await Permission.location.request();
    if (status.isDenied || status.isPermanentlyDenied) {
      Get.snackbar("Location Permission",
          "Location access needed to use Maps. You can enable it from app info.");
      openAppSettings();
    } else if (status.isGranted) {
      checkLocationAccess();
      return;
    }
  }
}
