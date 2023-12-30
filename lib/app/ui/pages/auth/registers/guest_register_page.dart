import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../../../core/configs/sizes.dart';
import '../../../../../core/configs/themes.dart';
import '../../../../../database/api/auth.dart';
import '../../../../controllers/members_controller.dart';

class GuestRegisterPage extends StatelessWidget {
  GuestRegisterPage({super.key}) {
    if (Auth().currentUser != null) {
      emailController.text = Auth().currentUser!.email!;
    }
  }

  static const String route = "/auth/register/guest";

  final TextEditingController nameController = TextEditingController();
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
                  "Guest Register".tr,
                  style: TextStyle(
                    fontSize: kTitleFontSize,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.error,
                  ),
                ),
              ),
              const SizedBox(height: kSizeBoxL),
              TextField(
                controller: nameController,
                style: const TextStyle(
                  //  color: kOnBackgroundColor,
                  fontSize: kSearchFontSize,
                ),
                decoration: InputDecoration(
                  labelText: 'Name'.tr,
                  hintText: 'Enter name'.tr,
                  labelStyle: const TextStyle(
                      //   color: kGreyColor,
                      ),
                  hintStyle: const TextStyle(
                      //   color: kGreyColor,
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
                controller: emailController,
                style: const TextStyle(
                  //   color: kOnBackgroundColor,
                  fontSize: kSearchFontSize,
                ),
                decoration: InputDecoration(
                  labelText: 'Email'.tr,
                  hintText: 'Enter email'.tr,
                  labelStyle: const TextStyle(
                      //   color: kGreyColor,
                      ),
                  hintStyle: const TextStyle(
                      // color: kGreyColor,
                      ),
                  filled: true,
                  // fillColor: kBackgroundColor,
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
                  // color: kOnBackgroundColor,
                  fontSize: kSearchFontSize,
                ),
                decoration: InputDecoration(
                  labelText: 'Password'.tr,
                  hintText: 'Enter password'.tr,
                  labelStyle: const TextStyle(
                      // color: kGreyColor,
                      ),
                  hintStyle: const TextStyle(
                      // color: kGreyColor,
                      ),
                  filled: true,
                  // fillColor: kBackgroundColor,
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
                    if (MembersController.to.isLogging.value)
                      SizedBox(
                        // width: 20,
                        // height: 20,
                        child: CircularProgressIndicator(
                          color: Theme.of(context).colorScheme.error,
                        ),
                      ),
                    if (!MembersController.to.isLogging.value)
                      OutlinedButton(
                        onPressed: () async {
                          MembersController.to.addMember(
                            name: nameController.text,
                            email: emailController.text,
                            password: passwordController.text,
                          );
                        },
                        style: OutlinedButton.styleFrom(
                          backgroundColor: Theme.of(context).colorScheme.error,
                          side: BorderSide(
                            color: Theme.of(context).colorScheme.background,
                          ),
                        ),
                        child: Text(
                          "Register".tr,
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.onError),
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
