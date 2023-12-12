import 'package:get/get.dart';

import '../../../core/configs/colors.dart';

class Snack {
  static void success(
    String message, {
    SnackPosition snackPosition = SnackPosition.TOP,
  }) {
    Get.snackbar(
      "Success",
      message,
      backgroundColor: kSuccessColor,
      colorText: kOnSuccessColor,
      snackPosition: snackPosition,
    );
  }

  static void error(
    String message, {
    SnackPosition snackPosition = SnackPosition.TOP,
  }) {
    Get.snackbar(
      "Error",
      message,
      backgroundColor: kErrorColor,
      colorText: kOnErrorColor,
      snackPosition: snackPosition,
    );
  }
}
