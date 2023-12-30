import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:kitaabua/app/services/auth_service.dart';

import '../../../../../core/configs/sizes.dart';
import '../../../../../core/configs/themes.dart';
import '../../../../../database/api/auth.dart';
import '../../../../controllers/members_controller.dart';
import '../../../widgets/snack.dart';

class PrincipalLoginPage extends StatelessWidget {
  PrincipalLoginPage({super.key}) {
    if (MembersController.to.currentMember.value != null) {
      emailController.text = MembersController.to.currentMember.value!.email;
    }
  }

  static const String route = "/auth/login/principal";

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness:
            Themes.isDark ? Brightness.light : Brightness.dark,
      ),
    );
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Text(
                  "Main Login".tr,
                  style: TextStyle(
                    fontSize: kTitleFontSize,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
              ),
              const SizedBox(height: kSizeBoxL),
              TextField(
                controller: emailController,
                style: const TextStyle(
                  // color: kOnBackgroundColor,
                  fontSize: kSearchFontSize,
                ),
                decoration: InputDecoration(
                  labelText: "Email".tr,
                  labelStyle: const TextStyle(
                      //      color: kGreyColor,
                      ),
                  filled: true,
                  //    fillColor: kBackgroundColor,
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
                  //    color: kOnBackgroundColor,
                  fontSize: kSearchFontSize,
                ),
                decoration: InputDecoration(
                  labelText: "Password".tr,
                  labelStyle: const TextStyle(
                      //       color: kGreyColor,
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
              Obx(() {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    OutlinedButton(
                      onPressed: () {
                        Get.back();
                      },
                      child: Text(
                        "Cancel".tr,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onBackground,
                        ),
                      ),
                    ),
                    // const Spacer(),
                    if (AuthService.to.isLogging.value)
                      SizedBox(
                        // width: 20,
                        // height: 20,
                        child: CircularProgressIndicator(
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                    if (!AuthService.to.isLogging.value)
                      OutlinedButton(
                        onPressed: () {
                          AuthService.to.isLogging.value = true;
                          Auth()
                              .signInWithEmailAndPassword(
                            email: emailController.text,
                            password: passwordController.text,
                          )
                              .then((value) {
                            Get.back();
                            Snack.success("Login success".tr);
                          }).catchError((onError) {
                            Snack.error(onError.toString());
                          }).whenComplete(() {
                            AuthService.to.isLogging.value = false;
                          });
                          // Get.back();
                        },
                        style: OutlinedButton.styleFrom(
                          backgroundColor:
                              Theme.of(context).colorScheme.secondary,
                          side: BorderSide(
                            color: Theme.of(context).colorScheme.background,
                          ),
                        ),
                        child: Text(
                          "Login".tr,
                          //         style: TextStyle(color: kBackgroundColor),
                        ),
                      ),
                  ],
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
