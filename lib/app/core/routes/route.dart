import 'package:get/get.dart';
import 'package:kvn_catering/app/common/modules/auth/auth.view.dart';
import 'package:kvn_catering/app/common/modules/catering/catering.view.dart';
import 'package:kvn_catering/app/common/modules/delivery/delivery.view.dart';
import 'package:kvn_catering/app/common/modules/profile/profile.view.dart';
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
    name: '/profile',
    page: () => const ProfileView(),
    binding: ProfileBinding(),
  ),
  GetPage(
    name: '/user',
    page: () => const UserView(),
    binding: UserBinding(),
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
    binding: OrderBinding(),
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
    name: '/catering',
    page: () => const CateringView(),
    binding: CateringBinding(),
  ),
  GetPage(
    name: '/delivery',
    page: () => const DeliveryView(),
    binding: DeliveryBinding(),
  ),
];
