import 'package:get/get.dart';

class Snack {
  static void success(
    String message, {
    SnackPosition snackPosition = SnackPosition.TOP,
  }) {
    Get.snackbar(
      "Success".tr,
      message,
      // backgroundColor: kSuccessColor,
      // colorText: kOnSuccessColor,
      snackPosition: snackPosition,
    );
  }

  static void error(
    String message, {
    SnackPosition snackPosition = SnackPosition.TOP,
  }) {
    Get.snackbar(
      "Error".tr,
      message,
      // backgroundColor: kErrorColor,
      // colorText: kOnErrorColor,
      snackPosition: snackPosition,
    );
  }
}
