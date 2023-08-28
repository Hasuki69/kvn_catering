import 'package:flutter/material.dart';
import 'package:get/get.dart';

void getLoading() {
  Get.dialog(
    const Center(
      child: Center(
        child: CircularProgressIndicator(),
      ),
    ),
    barrierDismissible: false,
  );
}

void closeLoading() {
  Get.back();
}
