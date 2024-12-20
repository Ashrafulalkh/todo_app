import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/ui/utils/app_colors.dart';

SnackbarController successSnackBar(String title, String message) {
  return Get.snackbar(title, message,
      colorText: Colors.white, backgroundColor: AppColors.themeColor);
}

SnackbarController failureSnackbar(String title, String message) {
  return Get.snackbar(title, message,
      colorText: Colors.white, backgroundColor: Colors.red);
}
