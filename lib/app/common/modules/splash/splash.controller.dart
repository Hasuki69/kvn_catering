import 'dart:async';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SplashController extends GetxController {
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
  var countdown = 1.obs;

  // ==================== FUCTIONS ====================

  get session => box.read('session') ?? false;
  get role => box.read('role') ?? 0;

  Timer timer() => Timer.periodic(
        const Duration(seconds: 1),
        (timer) {
          if (countdown.value == 0) {
            timer.cancel();
            if (!session) {
              Get.offAllNamed('/auth');
            } else {
              if (role == 1) {
                Get.offAllNamed('/user');
              } else if (role == 2) {
                Get.offAllNamed('/catering');
              } else if (role == 3) {
                Get.offAllNamed('/delivery');
              } else {
                Get.offAllNamed('/auth');
              }
            }
          } else {
            countdown.value--;
          }
        },
      );
}
