import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kvn_catering/app/common/modules/splash/splash.controller.dart';
import 'package:kvn_catering/app/core/configs/const.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    controller.timer();
    return Scaffold(
      extendBody: true,
      body: splashBody(
        context,
        controller: controller,
      ),
    );
  }
}

Widget splashBody(BuildContext context,
    {required SplashController controller}) {
  final size = MediaQuery.of(context).size;
  return Center(
    child: SizedBox(
      width: size.width * 0.6,
      height: size.width * 0.6,
      child: Image.asset(appLogoIcon),
    ),
  );
}
