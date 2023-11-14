import 'package:get/get.dart';
import 'package:kvn_catering/app/common/modules/auth/auth.view.dart';
import 'package:kvn_catering/app/common/modules/catering/budgeting/catering_budgeting.view.dart';
import 'package:kvn_catering/app/common/modules/catering/budgeting/catering_budgeting_detail.view.dart';
import 'package:kvn_catering/app/common/modules/catering/budgeting/catering_budgeting_form.view.dart';
import 'package:kvn_catering/app/common/modules/catering/catering.view.dart';
import 'package:kvn_catering/app/common/modules/catering/location/catering_location.view.dart';
import 'package:kvn_catering/app/common/modules/catering/menu/catering_menu.view.dart';
import 'package:kvn_catering/app/common/modules/catering/notification/catering_notification.view.dart';
import 'package:kvn_catering/app/common/modules/catering/notification/catering_notification_detail.view.dart';
import 'package:kvn_catering/app/common/modules/catering/order/catering_order.view.dart';
import 'package:kvn_catering/app/common/modules/catering/pengantar/catering_pengantar.view.dart';
import 'package:kvn_catering/app/common/modules/catering/profile/catering_profile.view.dart';
import 'package:kvn_catering/app/common/modules/delivery/delivery.view.dart';
import 'package:kvn_catering/app/common/modules/delivery/delivery_detail.dart';
import 'package:kvn_catering/app/common/modules/user/catering/pembayaran.view.dart';
import 'package:kvn_catering/app/common/modules/user/profile/user_profile.view.dart';
import 'package:kvn_catering/app/common/modules/splash/splash.view.dart';
import 'package:kvn_catering/app/common/modules/user/catering/catering_detail.view.dart';
import 'package:kvn_catering/app/common/modules/user/catering/catering_list.view.dart';
import 'package:kvn_catering/app/common/modules/user/order/order.view.dart';
import 'package:kvn_catering/app/common/modules/user/order/order_detail.dart';
import 'package:kvn_catering/app/common/modules/user/recipt/recipt.view.dart';
import 'package:kvn_catering/app/common/modules/user/recipt/recipt_detail.view.dart';
import 'package:kvn_catering/app/common/modules/user/user.view.dart';
import 'package:kvn_catering/app/core/configs/bindings.dart';
import 'package:kvn_catering/app/core/configs/const.dart';

List<GetPage<dynamic>> getPages = [
  GetPage(
    name: initialRoute,
    page: () => const SplashView(),
    binding: SplashBinding(),
  ),
  GetPage(
    name: '/auth',
    page: () => const AuthView(),
    binding: AuthBinding(),
  ),
  GetPage(
    name: '/user',
    page: () => const UserView(),
    binding: UserBinding(),
  ),
  GetPage(
    name: '/user/profile',
    page: () => const UserProfileView(),
    binding: UserProfileBinding(),
  ),
  GetPage(
    name: '/user/recipt',
    page: () => const ReciptView(),
    binding: ReciptBinding(),
  ),
  GetPage(
    name: '/user/recipt/detail',
    page: () => const ReciptDetailView(),
    binding: ReciptBinding(),
  ),
  GetPage(
    name: '/user/order',
    page: () => const OrderView(),
    bindings: [
      OrderBinding(),
      GmapBinding(),
    ],
  ),
  GetPage(
    name: '/user/order/detail',
    page: () => const OrderDetailView(),
    binding: OrderBinding(),
  ),
  GetPage(
    name: '/user/catering-list',
    page: () => const CateringListView(),
    binding: CateringListBinding(),
  ),
  GetPage(
    name: '/user/catering-list/detail',
    page: () => const CateringDetailView(),
    bindings: [
      CateringListBinding(),
      GmapBinding(),
    ],
  ),
  GetPage(
    name: '/user/catering-list/detail-payment',
    page: () => const PembayaranCateringView(),
    bindings: [
      CateringListBinding(),
    ],
  ),
  GetPage(
    name: '/catering',
    page: () => const CateringView(),
    binding: CateringBinding(),
  ),
  GetPage(
    name: '/catering/profile',
    page: () => const CateringProfileView(),
    binding: CateringProfileBinding(),
  ),
  GetPage(
    name: '/catering/notification',
    page: () => const CateringNotificationView(),
    binding: CateringNotificationBinding(),
  ),
  GetPage(
    name: '/catering/notification-detail',
    page: () => const CateringNotificationDetailView(),
    binding: CateringNotificationBinding(),
  ),
  GetPage(
    name: '/catering/menu',
    page: () => const CateringMenuView(),
    binding: CateringMenuBinding(),
  ),
  GetPage(
    name: '/catering/location',
    page: () => const CateringLocationView(),
    bindings: [
      CateringLocationBinding(),
      GmapBinding(),
    ],
  ),
  GetPage(
    name: '/catering/budgeting',
    page: () => const CateringBudgetingView(),
    binding: CateringBudgetingBinding(),
  ),
  GetPage(
    name: '/catering/budgeting/detail',
    page: () => const CateringBudgetingDetailView(),
    binding: CateringBudgetingBinding(),
  ),
  GetPage(
    name: '/catering/budgeting/form',
    page: () => const CateringBudgetingFormView(),
    binding: CateringBudgetingBinding(),
  ),
  GetPage(
    name: '/catering/pengantar',
    page: () => const CateringPengantarView(),
    binding: CateringPengantarBinding(),
  ),
  GetPage(
    name: '/catering/order',
    page: () => const CateringOrderView(),
    binding: CateringOrderBinding(),
  ),
  GetPage(
    name: '/delivery',
    page: () => const DeliveryView(),
    bindings: [
      DeliveryBinding(),
      GmapBinding(),
    ],
  ),
  GetPage(
    name: '/delivery/detail',
    page: () => const DeliveryDetailView(),
    bindings: [
      DeliveryBinding(),
      GmapBinding(),
    ],
  ),
];
