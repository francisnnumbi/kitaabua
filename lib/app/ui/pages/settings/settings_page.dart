import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kitaabua/app/ui/pages/auth/profile/profile_page.dart';
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
            const SimpleAppBarHeader(
              icon: Icons.settings,
              title: "Settings",
              titleFontSize: kSubTitleFontSize,
            ),
            const SizedBox(height: kSizeBoxM),
            Expanded(
                child: ListView(
              padding: const EdgeInsets.all(0),
              children: [
                ListTile(
                  title: const Text("Profile",
                      style: TextStyle(color: kOnBackgroundColor)),
                  subtitle: const Text("Manage your profile",
                      style: TextStyle(color: kGreyColor)),
                  leading: const Icon(Icons.account_circle, color: kGreyColor),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    Get.toNamed(ProfilePage.route);
                  },
                ),
                ListTile(
                  title: const Text("Settings",
                      style: TextStyle(color: kOnBackgroundColor)),
                  subtitle: const Text("Manage your settings",
                      style: TextStyle(color: kGreyColor)),
                  leading: const Icon(Icons.settings, color: kGreyColor),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {},
                ),
                ListTile(
                  title: const Text("Notifications",
                      style: TextStyle(color: kOnBackgroundColor)),
                  subtitle: const Text("Manage your notifications",
                      style: TextStyle(color: kGreyColor)),
                  leading: const Icon(Icons.notifications, color: kGreyColor),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {},
                ),
                ListTile(
                  title: const Text("Privacy",
                      style: TextStyle(color: kOnBackgroundColor)),
                  subtitle: const Text("Manage your privacy",
                      style: TextStyle(color: kGreyColor)),
                  leading: const Icon(Icons.privacy_tip, color: kGreyColor),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {},
                ),
                ListTile(
                  title: const Text("About",
                      style: TextStyle(color: kOnBackgroundColor)),
                  subtitle: const Text("About this app",
                      style: TextStyle(color: kGreyColor)),
                  leading: const Icon(Icons.info, color: kGreyColor),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {},
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
