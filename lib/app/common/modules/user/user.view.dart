import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:kvn_catering/app/common/modules/user/user.controller.dart';
import 'package:kvn_catering/app/common/modules/user/user_sidebar.view.dart';
import 'package:kvn_catering/app/common/widgets/custom_elevation.dart';
import 'package:kvn_catering/app/common/widgets/custom_text.dart';
import 'package:kvn_catering/app/core/configs/const.dart';
import 'package:kvn_catering/app/core/themes/theme.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class UserView extends GetView<UserController> {
  const UserView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: userAppbar(context, controller: controller),
      endDrawer: userSidebar(context, controller: controller),
      body: SingleChildScrollView(
        controller: ScrollController(),
        child: userBody(context, controller: controller),
      ),
    );
  }
}

PreferredSizeWidget userAppbar(BuildContext context,
    {required UserController controller}) {
  return AppBar(
    centerTitle: true,
    forceMaterialTransparency: true,
    title: SizedBox(
      width: 56,
      height: 56,
      child: Image.asset(appLogoIcon),
    ),
    bottom: PreferredSize(
      preferredSize: const Size.fromHeight(1),
      child: Container(
        color: AppColor.onPrimary.withOpacity(0.05),
        height: 1,
      ),
    ),
  );
}

Widget userBody(BuildContext context, {required UserController controller}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 24),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ReText(
          value: 'Menu',
          style: AppStyle().headingSmall,
          padding: const EdgeInsets.symmetric(horizontal: 32),
        ),
        userBodyMenu(context, controller: controller),
        ReText(
          value: 'Promo',
          style: AppStyle().headingSmall,
          padding: const EdgeInsets.symmetric(horizontal: 32),
        ),
        userBodyBanner(context, controller: controller),
        ReText(
          value: 'Terbaru',
          style: AppStyle().headingSmall,
          padding: const EdgeInsets.symmetric(horizontal: 32),
        ),
      ],
    ),
  );
}

Widget userBodyMenu(BuildContext context,
    {required UserController controller}) {
  return GridView(
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 4,
      mainAxisSpacing: 8,
      crossAxisSpacing: 8,
      childAspectRatio: 1 / 1.5,
    ),
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
    children: List.generate(
      controller.menuItem().length,
      (index) {
        return GestureDetector(
          onTap: () {
            controller.locationServices.locationPermission().whenComplete(() {
              Get.toNamed(
                '/user/catering-list',
                parameters: {
                  'category': controller.menuItem()[index][0],
                  'itemIcon': controller.menuItem()[index][1],
                  'appbarBanner': controller.menuItem()[index][2],
                  'index': index.toString(),
                },
              );
            });
          },
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ReElevation(
                child: Card(
                  clipBehavior: Clip.antiAlias,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: BorderSide(
                      color: AppColor.accent.withOpacity(0.4),
                      width: 1,
                    ),
                  ),
                  color: AppColor.background,
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: Image(
                        fit: BoxFit.fitWidth,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        },
                        image: AssetImage(
                          controller.menuItem()[index][1],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              ReText(
                value: controller.menuItem()[index][0],
                style: AppStyle().titleMedium,
                maxLines: 2,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        );
      },
    ),
  );
}

Widget userBodyBanner(BuildContext context,
    {required UserController controller}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        CarouselSlider.builder(
          itemCount: controller.bannerItem().length,
          itemBuilder: (context, index, realIndex) {
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: AppColor.netral.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
                image: DecorationImage(
                  image: AssetImage(
                    controller.bannerItem()[index],
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
          options: CarouselOptions(
            aspectRatio: 21 / 9,
            viewportFraction: 1,
            autoPlay: true,
            onPageChanged: (index, reason) {
              controller.bannerIndex(index);
            },
          ),
        ),
        const SizedBox(height: 8),
        Obx(
          () => AnimatedSmoothIndicator(
            activeIndex: controller.bannerIndex(),
            count: controller.bannerItem().length,
            effect: WormEffect(
              dotHeight: 8,
              dotWidth: 8,
              activeDotColor: AppColor.accent,
              dotColor: AppColor.netral.withOpacity(0.4),
            ),
          ),
        ),
      ],
    ),
  );
}
