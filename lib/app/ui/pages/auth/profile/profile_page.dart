import 'package:flutter/material.dart';
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
        child: Column(
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
                children: const [
                  ListTile(
                    title: Text("Email address",
                        style: TextStyle(color: kOnBackgroundColor)),
                    subtitle:
                        Text("email", style: TextStyle(color: kGreyColor)),
                    leading: Icon(Icons.account_circle, color: kGreyColor),
                  ),
                ],
              ),
            ),
            const SizedBox(height: kSizeBoxM),
            if (!AuthService.to.isLoggedIn.value)
              ElevatedButton(
                onPressed: () {},
                child: const Text("Login"),
              ),
            if (AuthService.to.isLoggedIn.value)
              ElevatedButton(
                onPressed: () {},
                child: const Text("Sign out"),
              ),
          ],
        ),
      ),
    );
  }
}
