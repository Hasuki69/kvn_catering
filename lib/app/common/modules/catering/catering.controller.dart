import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class CateringController extends GetxController {
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

  // ==================== FUCTIONS ====================

  get session => box.read('session') ?? false;
  get uid => box.read('uid') ?? '';
  get role => box.read('role') ?? 0;

  void logout() {
    box.erase();
    Get.offAllNamed('/auth');
  }
}
