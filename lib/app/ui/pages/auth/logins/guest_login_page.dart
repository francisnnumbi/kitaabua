import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../../../core/configs/sizes.dart';
import '../../../../../core/configs/themes.dart';
import '../../../../../main.dart';
import '../../../../controllers/members_controller.dart';
import '../../../widgets/snack.dart';

class GuestLoginPage extends StatelessWidget {
  GuestLoginPage({super.key});

  static const String route = "/auth/login/guest";

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
                  "Guest Login".tr,
                  style: TextStyle(
                    fontSize: kTitleFontSize,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.error,
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
                  labelText: 'Email'.tr,
                  hintText: 'Enter email'.tr,
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
                          MembersController.to.isLogging.value = true;
                          await 0.5.delay();
                          for (final member in MembersController.to.members) {
                            if (member.email == emailController.text &&
                                member.password == passwordController.text &&
                                member.state == true) {
                              MembersController.to.currentMember.value = member;
                              InnerStorage.write(
                                'currentMember',
                                MembersController.to.currentMember.value!
                                    .toStringJson(),
                              );
                              MembersController.to.isLogging.value = false;
                              Get.back();
                              Snack.success('Guest logged in successfully'.tr);
                              return;
                            }
                          }
                          if (MembersController.to.currentMember.value ==
                              null) {
                            Snack.error('Guest not found'.tr);
                          }
                          MembersController.to.isLogging.value = false;
                        },
                        style: OutlinedButton.styleFrom(
                          backgroundColor: Theme.of(context).colorScheme.error,
                          side: BorderSide(
                            color: Theme.of(context).colorScheme.background,
                          ),
                        ),
                        child: Text(
                          "Login".tr,
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
