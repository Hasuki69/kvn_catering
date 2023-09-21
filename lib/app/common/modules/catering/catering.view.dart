import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kvn_catering/app/common/modules/catering/catering.controller.dart';
import 'package:kvn_catering/app/common/modules/catering/catering_sidebar.view.dart';
import 'package:kvn_catering/app/common/widgets/custom_elevation.dart';
import 'package:kvn_catering/app/common/widgets/custom_text.dart';
import 'package:kvn_catering/app/core/configs/const.dart';
import 'package:kvn_catering/app/core/themes/theme.dart';

class CateringView extends GetView<CateringController> {
  const CateringView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: cateringAppbar(context, controller: controller),
      endDrawer: cateringSidebar(context, controller: controller),
      body: SingleChildScrollView(
        controller: ScrollController(),
        child: userBody(context, controller: controller),
      ),
    );
  }
}

PreferredSizeWidget cateringAppbar(BuildContext context,
    {required CateringController controller}) {
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

Widget userBody(BuildContext context,
    {required CateringController controller}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 24),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        cateringBodyMenu(context, controller: controller),
      ],
    ),
  );
}

Widget cateringBodyMenu(BuildContext context,
    {required CateringController controller}) {
  return GridView(
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      mainAxisSpacing: 8,
      crossAxisSpacing: 56,
      childAspectRatio: 3.5 / 3,
    ),
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
    children: List.generate(
      controller.menuItem().length,
      (index) {
        return GestureDetector(
          onTap: () {
            Get.toNamed(controller.menuItem()[index][2]);
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
                      aspectRatio: 5 / 3,
                      child: Image(
                        fit: BoxFit.fitHeight,
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
