import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kitaabua/database/api/auth.dart';

import '../../core/configs/sizes.dart';
import '../ui/widgets/snack.dart';

class AuthService extends GetxService {
  // ------- static methods ------- //
  static AuthService get to => Get.find();

  static Future<void> init() async {
    await Get.putAsync<AuthService>(() async => AuthService());
  }

// ------- ./static methods ------- //

  final RxBool isLoggedIn = false.obs;
  final RxString uid = ''.obs;
  final RxBool isLogging = false.obs;

  User? get currentUser => Auth().currentUser;

  void login() {
    isLoggedIn.value = true;
  }

  void registerDialog() {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    Get.defaultDialog(
      title: "Register".tr,
      content: Column(
        children: [
          TextField(
            controller: emailController,
            style: const TextStyle(
              //   color: kOnBackgroundColor,
              fontSize: kSearchFontSize,
            ),
            decoration: InputDecoration(
              labelText: "Email".tr,
              labelStyle: const TextStyle(
                  //  color: kGreyColor,
                  ),
              filled: true,
              //  fillColor: kBackgroundColor,
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent),
                borderRadius: BorderRadius.all(
                  Radius.circular(kBorderRadiusS),
                ),
              ),
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent),
                borderRadius: BorderRadius.all(
                  Radius.circular(kBorderRadiusS),
                ),
              ),
            ),
          ),
          const SizedBox(height: kSizeBoxM),
          TextField(
            controller: passwordController,
            style: const TextStyle(
              //  color: kOnBackgroundColor,
              fontSize: kSearchFontSize,
            ),
            decoration: InputDecoration(
              labelText: "Password".tr,
              labelStyle: const TextStyle(
                  //    color: kGreyColor,
                  ),
              filled: true,
              //   fillColor: kBackgroundColor,
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent),
                borderRadius: BorderRadius.all(
                  Radius.circular(kBorderRadiusS),
                ),
              ),
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent),
                borderRadius: BorderRadius.all(
                  Radius.circular(kBorderRadiusS),
                ),
              ),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
          },
          child: Text(
            "Cancel".tr,
            //   style: const TextStyle(color: kGreyColor),
          ),
        ),
        TextButton(
          onPressed: () {
            Auth()
                .createUserWithEmailAndPassword(
              email: emailController.text,
              password: passwordController.text,
            )
                .then((value) {
              Get.back();
              Snack.success("Register success".tr);
            }).catchError((onError) {
              Snack.error(onError.toString());
            });
            // Get.back();
          },
          child: Text(
            "Register".tr,
            //       style: TextStyle(color: kBackgroundColor),
          ),
        ),
      ],
    );
  }

  void logoutDialog() {
    Get.defaultDialog(
      title: "Logout".tr,
      content: Text("Are you sure you want to logout?".tr),
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
          },
          child: Text("Cancel".tr),
        ),
        TextButton(
          onPressed: () {
            Auth().signOut().then((value) {
              Get.back();
              Snack.success("Logout success".tr);
            }).catchError((onError) {
              Snack.error(onError.toString());
            });
            // Get.back();
          },
          child: Text("Logout".tr),
        ),
      ],
    );
  }

  void logout() {
    isLoggedIn.value = false;
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    Auth().authStateChanges.listen((User? user) {
      if (user == null) {
        logout();
        uid.value = '';
      } else {
        login();
        uid.value = user.uid;
      }
    });
  }
}
