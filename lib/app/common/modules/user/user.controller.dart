import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:permission_handler/permission_handler.dart';

class UserController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  // ==================== VARIABLES ====================
  GetStorage box = GetStorage();

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
  get role => box.read('role') ?? 0;

  void logout() {
    box.erase();
    Get.offAllNamed('/auth');
  }

  Future<void> locationPermission() async {
    final PermissionStatus status = await Permission.location.request();
    if (status.isDenied || status.isPermanentlyDenied) {
      Get.snackbar("Location Permission",
          "Location access needed to use Maps. You can enable it from app info.");
      openAppSettings();
    } else if (status.isGranted) {
      return;
    }
  }
}