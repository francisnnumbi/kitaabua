import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kitaabua/database/api/auth.dart';

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
    Get.defaultDialog(
      title: "Login",
      content: Column(
        children: [
          TextField(
            controller: emailController,
            decoration: const InputDecoration(
              labelText: "Email",
            ),
          ),
          TextField(
            controller: passwordController,
            decoration: const InputDecoration(
              labelText: "Password",
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
          },
          child: const Text("Cancel"),
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
              Get.snackbar('Success', "Login success");
            }).catchError((onError) {
              Get.snackbar('Error', onError.toString());
            });
            // Get.back();
          },
          child: const Text("Login"),
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
            decoration: const InputDecoration(
              labelText: "Email",
            ),
          ),
          TextField(
            controller: passwordController,
            decoration: const InputDecoration(
              labelText: "Password",
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
          },
          child: const Text("Cancel"),
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
              Get.snackbar('Success', "Register success");
            }).catchError((onError) {
              Get.snackbar('Error', onError.toString());
            });
            // Get.back();
          },
          child: const Text("Register"),
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
              Get.snackbar('Success', "Logout success");
            }).catchError((onError) {
              Get.snackbar('Error', onError.toString());
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
