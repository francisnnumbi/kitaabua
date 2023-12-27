import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:kitaabua/app/ui/pages/auth/profile/profile_page.dart';
import 'package:kitaabua/app/ui/pages/settings/options_page.dart';
import 'package:kitaabua/app/ui/widgets/dialogs/options_dialogs.dart';
import 'package:kitaabua/core/configs/sizes.dart';

import '../../../../core/configs/themes.dart';
import '../../widgets/botto_nav_bar.dart';
import '../../widgets/simple_app_bar_header.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  static const String route = "/settings";

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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
          child: Column(
            children: [
              SimpleAppBarHeader(
                icon: Icons.settings,
                title: "Settings".tr,
                titleFontSize: kSubTitleFontSize,
              ),
              const SizedBox(height: kSizeBoxM),
              Expanded(
                  child: ListView(
                padding: const EdgeInsets.all(0),
                children: [
                  ListTile(
                    title: Text(
                      "Profile".tr,
                      //   style: const TextStyle(color: kOnBackgroundColor),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    subtitle: Text(
                      "Manage your profile".tr,
                      //    style: const TextStyle(color: kGreyColor),
                    ),
                    leading: const Icon(
                      Icons.account_circle,
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      Get.toNamed(ProfilePage.route);
                    },
                  ),
                  const SizedBox(height: kSizeBoxS),
                  ListTile(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    title: Text(
                      "Options".tr,
                      //   style: const TextStyle(color: kOnBackgroundColor),
                    ),
                    subtitle: Text(
                      "Manage your options".tr,
                      //   style: const TextStyle(color: kGreyColor),
                    ),
                    leading: const Icon(
                      Icons.settings,
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      Get.toNamed(OptionsPage.route);
                    },
                  ),
                  const SizedBox(height: kSizeBoxS),
                  ListTile(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    title: Text(
                      "Notifications".tr,
                    ),
                    subtitle: Text(
                      "Manage your notifications".tr,
                    ),
                    leading: const Icon(
                      Icons.notifications,
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {},
                  ),
                  const SizedBox(height: kSizeBoxS),
                  ListTile(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    title: Text(
                      "Privacy".tr,
                    ),
                    subtitle: Text(
                      "View privacy policy".tr,
                    ),
                    leading: const Icon(
                      Icons.privacy_tip,
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {},
                  ),
                  const SizedBox(height: kSizeBoxS),
                  ListTile(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    title: Text(
                      "Contributors".tr,
                    ),
                    subtitle: Text(
                      "View contributors".tr,
                    ),
                    leading: const Icon(
                      Icons.people,
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {},
                  ),
                  const SizedBox(height: kSizeBoxS),
                  ListTile(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    title: Text(
                      "About".tr,
                    ),
                    subtitle: Text(
                      "About this app".tr,
                    ),
                    leading: const Icon(
                      Icons.info,
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      openAboutDialog();
                    },
                  ),
                ],
              )),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}
