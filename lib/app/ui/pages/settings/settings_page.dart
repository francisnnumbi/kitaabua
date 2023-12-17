import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kitaabua/app/ui/pages/auth/profile/profile_page.dart';
import 'package:kitaabua/app/ui/pages/settings/options_page.dart';
import 'package:kitaabua/app/ui/widgets/dialogs/options_dialogs.dart';
import 'package:kitaabua/core/configs/colors.dart';
import 'package:kitaabua/core/configs/sizes.dart';

import '../../widgets/botto_nav_bar.dart';
import '../../widgets/simple_app_bar_header.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  static const String route = "/settings";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 40, 16, 0),
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
                  title: Text("Profile".tr,
                      style: const TextStyle(color: kOnBackgroundColor)),
                  subtitle: Text("Manage your profile".tr,
                      style: const TextStyle(color: kGreyColor)),
                  leading: const Icon(Icons.account_circle, color: kGreyColor),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    Get.toNamed(ProfilePage.route);
                  },
                ),
                ListTile(
                  title: Text("Options".tr,
                      style: const TextStyle(color: kOnBackgroundColor)),
                  subtitle: Text("Manage your options".tr,
                      style: const TextStyle(color: kGreyColor)),
                  leading: const Icon(Icons.settings, color: kGreyColor),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    Get.toNamed(OptionsPage.route);
                  },
                ),
                ListTile(
                  title: Text("Notifications".tr,
                      style: const TextStyle(color: kOnBackgroundColor)),
                  subtitle: Text("Manage your notifications".tr,
                      style: const TextStyle(color: kGreyColor)),
                  leading: const Icon(Icons.notifications, color: kGreyColor),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {},
                ),
                ListTile(
                  title: Text("Privacy".tr,
                      style: const TextStyle(color: kOnBackgroundColor)),
                  subtitle: Text("View privacy policy".tr,
                      style: const TextStyle(color: kGreyColor)),
                  leading: const Icon(Icons.privacy_tip, color: kGreyColor),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {},
                ),
                ListTile(
                  title: Text("Contributors".tr,
                      style: const TextStyle(color: kOnBackgroundColor)),
                  subtitle: Text("View contributors".tr,
                      style: const TextStyle(color: kGreyColor)),
                  leading: const Icon(Icons.people, color: kGreyColor),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {},
                ),
                ListTile(
                  title: Text("About".tr,
                      style: const TextStyle(color: kOnBackgroundColor)),
                  subtitle: Text("About this app".tr,
                      style: const TextStyle(color: kGreyColor)),
                  leading: const Icon(Icons.info, color: kGreyColor),
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
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}
