import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kitaabua/app/controllers/members_controller.dart';
import 'package:kitaabua/database/api/auth.dart';

import '../../core/configs/colors.dart';
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

  User? get currentUser => Auth().currentUser;

  void login() {
    isLoggedIn.value = true;
  }

  void loginDialog() {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    if (MembersController.to.currentMember.value != null) {
      emailController.text = MembersController.to.currentMember.value!.email;
    }
    Get.defaultDialog(
      title: "Login",
      content: Column(
        children: [
          TextField(
            controller: emailController,
            style: const TextStyle(
              color: kOnBackgroundColor,
              fontSize: kSearchFontSize,
            ),
            decoration: InputDecoration(
              labelText: "Email",
              labelStyle: const TextStyle(
                color: kGreyColor,
              ),
              filled: true,
              fillColor: kBackgroundColor,
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
              color: kOnBackgroundColor,
              fontSize: kSearchFontSize,
            ),
            decoration: InputDecoration(
              labelText: "Password",
              labelStyle: const TextStyle(
                color: kGreyColor,
              ),
              filled: true,
              fillColor: kBackgroundColor,
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
          child: const Text("Cancel", style: TextStyle(color: kGreyColor)),
        ),
        TextButton(
          onPressed: () {
            Auth()
                .signInWithEmailAndPassword(
              email: emailController.text,
              password: passwordController.text,
            )
                .then((value) {
              Get.back();
              Snack.success("Login success");
            }).catchError((onError) {
              Snack.error(onError.toString());
            });
            // Get.back();
          },
          child: Text("Login", style: TextStyle(color: kBackgroundColor)),
        ),
      ],
    );
  }

  void registerDialog() {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    Get.defaultDialog(
      title: "Register",
      content: Column(
        children: [
          TextField(
            controller: emailController,
            style: const TextStyle(
              color: kOnBackgroundColor,
              fontSize: kSearchFontSize,
            ),
            decoration: InputDecoration(
              labelText: "Email",
              labelStyle: const TextStyle(
                color: kGreyColor,
              ),
              filled: true,
              fillColor: kBackgroundColor,
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
              color: kOnBackgroundColor,
              fontSize: kSearchFontSize,
            ),
            decoration: InputDecoration(
              labelText: "Password",
              labelStyle: const TextStyle(
                color: kGreyColor,
              ),
              filled: true,
              fillColor: kBackgroundColor,
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
          child: const Text(
            "Cancel",
            style: TextStyle(color: kGreyColor),
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
              Snack.success("Register success");
            }).catchError((onError) {
              Snack.error(onError.toString());
            });
            // Get.back();
          },
          child: Text("Register", style: TextStyle(color: kBackgroundColor)),
        ),
      ],
    );
  }

  void logoutDialog() {
    Get.defaultDialog(
      title: "Logout",
      content: const Text("Are you sure you want to logout?"),
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
          },
          child: const Text("Cancel"),
        ),
        TextButton(
          onPressed: () {
            Auth().signOut().then((value) {
              Get.back();
              Snack.success("Logout success");
            }).catchError((onError) {
              Snack.error(onError.toString());
            });
            // Get.back();
          },
          child: const Text("Logout"),
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
