import 'package:flutter/material.dart';
import 'package:kitaabua/core/configs/colors.dart';
import 'package:kitaabua/core/configs/sizes.dart';

import '../../widgets/app_bar_header.dart';
import '../../widgets/botto_nav_bar.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  static const String route = "/settings";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: const Padding(
        padding: EdgeInsets.fromLTRB(16, 40, 16, 0),
        child: Column(
          children: [
            AppBarHeader(
              hasBackButton: true,
              title: "Settings",
              titleFontSize: kSubTitleFontSize,
            ),
            SizedBox(height: kSizeBoxM),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}
