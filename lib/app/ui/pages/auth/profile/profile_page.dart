import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kitaabua/app/controllers/members_controller.dart';
import 'package:kitaabua/app/services/auth_service.dart';
import 'package:kitaabua/core/configs/colors.dart';
import 'package:kitaabua/core/configs/sizes.dart';

import '../../../widgets/app_bar_header.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  static const String route = "/auth/profile";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 40, 16, 0),
        child: Obx(() {
          return Column(
            children: [
              const AppBarHeader(
                hasBackButton: true,
                icon: Icons.account_circle_outlined,
                title: "Profile",
                titleFontSize: kSubTitleFontSize,
              ),
              const SizedBox(height: kSizeBoxM),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(0),
                  children: [
                    ListTile(
                      title: Text(
                          MembersController.to.currentMember.value?.name ??
                              "Not logged in !",
                          style: const TextStyle(color: kOnBackgroundColor)),
                      subtitle: const Text("Name",
                          style: TextStyle(color: kGreyColor)),
                      leading:
                          const Icon(Icons.account_circle, color: kGreyColor),
                    ),
                    ListTile(
                      title: Text(
                          AuthService.to.currentUser?.email ??
                              "Not logged in !",
                          style: const TextStyle(color: kOnBackgroundColor)),
                      subtitle: const Text("principal email",
                          style: TextStyle(color: kGreyColor)),
                      leading:
                          const Icon(Icons.mail_outline, color: kGreyColor),
                    ),
                    ListTile(
                      title: Text(
                          MembersController.to.currentMember.value?.email ??
                              "Not logged in !",
                          style: const TextStyle(color: kOnBackgroundColor)),
                      subtitle: const Text("secondary email",
                          style: TextStyle(color: kGreyColor)),
                      leading:
                          const Icon(Icons.mail_outline, color: kGreyColor),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: kSizeBoxM),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        const Text(
                          'Logged in as Principal',
                          style: TextStyle(color: kOnBackgroundColor),
                        ),
                        if (!AuthService.to.isLoggedIn.value)
                          ElevatedButton(
                            onPressed: () {
                              AuthService.to.loginDialog();
                            },
                            child: const Text("Sign in"),
                          ),
                        if (!AuthService.to.isLoggedIn.value)
                          ElevatedButton(
                            onPressed: () {
                              AuthService.to.registerDialog();
                            },
                            child: const Text("Register"),
                          ),
                        if (AuthService.to.isLoggedIn.value)
                          ElevatedButton(
                            onPressed: () {
                              AuthService.to.logoutDialog();
                            },
                            child: const Text("Sign out"),
                          ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        const Text(
                          'Logged in as Guest',
                          style: TextStyle(color: kOnBackgroundColor),
                        ),
                        if (MembersController.to.currentMember.value == null)
                          ElevatedButton(
                            onPressed: () {
                              MembersController.to.loginMemberDialog();
                            },
                            child: const Text("Login"),
                          ),
                        if (MembersController.to.currentMember.value == null)
                          ElevatedButton(
                            onPressed: () {
                              MembersController.to.addMemberDialog();
                            },
                            child: const Text("Register"),
                          ),
                        if (MembersController.to.currentMember.value != null)
                          ElevatedButton(
                            onPressed: () {
                              MembersController.to.logoutMemberDialog();
                            },
                            child: const Text("Logout"),
                          ),
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(height: kSizeBoxL),
            ],
          );
        }),
      ),
    );
  }
}
