import 'package:get/get.dart';
import 'package:kvn_catering/app/common/modules/auth/auth.controller.dart';
import 'package:kvn_catering/app/common/modules/catering/catering.controller.dart';
import 'package:kvn_catering/app/common/modules/delivery/delivery.controller.dart';
import 'package:kvn_catering/app/common/modules/profile/profile.controller.dart';
import 'package:kvn_catering/app/common/modules/splash/splash.controller.dart';
import 'package:kvn_catering/app/common/modules/user/catering/catering_list.controller.dart';
import 'package:kvn_catering/app/common/modules/user/user.controller.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SplashController());
  }
}

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthController());
  }
}

class UserBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => UserController());
  }
}

class CateringBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CateringController());
  }
}

class DeliveryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DeliveryController());
  }
}

class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProfileController());
  }
}

class CateringListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CateringListController());
  }
}
