import 'package:get/get.dart';
import 'package:kvn_catering/app/common/modules/auth/auth.controller.dart';
import 'package:kvn_catering/app/common/modules/catering/budgeting/catering_budgeting.controller.dart';
import 'package:kvn_catering/app/common/modules/catering/catering.controller.dart';
import 'package:kvn_catering/app/common/modules/catering/location/catering_location.controller.dart';
import 'package:kvn_catering/app/common/modules/catering/menu/catering_menu.controller.dart';
import 'package:kvn_catering/app/common/modules/catering/notification/catering_notification.controller.dart';
import 'package:kvn_catering/app/common/modules/catering/order/catering_order.controller.dart';
import 'package:kvn_catering/app/common/modules/catering/pengantar/catering_pengantar.controller.dart';
import 'package:kvn_catering/app/common/modules/catering/profile/catering_profile.controller.dart';
import 'package:kvn_catering/app/common/modules/delivery/delivery.controller.dart';
import 'package:kvn_catering/app/common/modules/gmap/gmap.controller.dart';
import 'package:kvn_catering/app/common/modules/user/profile/user_profile.controller.dart';
import 'package:kvn_catering/app/common/modules/splash/splash.controller.dart';
import 'package:kvn_catering/app/common/modules/user/catering/catering_list.controller.dart';
import 'package:kvn_catering/app/common/modules/user/order/order.controller.dart';
import 'package:kvn_catering/app/common/modules/user/recipt/recipt.controller.dart';
import 'package:kvn_catering/app/common/modules/user/user.controller.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SplashController(), fenix: true);
  }
}

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthController(), fenix: true);
  }
}

class UserBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => UserController(), fenix: true);
  }
}

class CateringBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CateringController(), fenix: true);
  }
}

class DeliveryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DeliveryController(), fenix: true);
  }
}

class UserProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => UserProfileController(), fenix: true);
  }
}

class CateringProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CateringProfileController(), fenix: true);
  }
}

class CateringNotificationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CateringNotificationController(), fenix: true);
  }
}

class CateringListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CateringListController(), fenix: true);
  }
}

class OrderBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => OrderController(), fenix: true);
  }
}

class ReciptBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ReciptController(), fenix: true);
  }
}

class GmapBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => GmapController(), fenix: true);
  }
}

class CateringMenuBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CateringMenuController(), fenix: true);
  }
}

class CateringLocationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CateringLocationController(), fenix: true);
  }
}

class CateringBudgetingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CateringBudgetingController(), fenix: true);
  }
}

class CateringPengantarBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CateringPengantarController(), fenix: true);
  }
}

class CateringOrderBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CateringOrderController(), fenix: true);
  }
}
