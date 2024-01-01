import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:kitaabua/app/services/settings_service.dart';

import '../../../../core/configs/sizes.dart';
import '../../../../core/configs/themes.dart';
import '../../widgets/app_bar_header.dart';

class PrivacyStatementPage extends StatelessWidget {
  const PrivacyStatementPage({super.key});

  static const String route = "/settings/privacy-statement";

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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
          child: Column(
            children: [
              AppBarHeader(
                hasBackButton: true,
                icon: Icons.privacy_tip,
                title: "Privacy".tr,
                titleFontSize: kSubTitleFontSize,
                onPressed: () {},
              ),
              const SizedBox(height: kSizeBoxM),
              Expanded(
                child: Scrollable(
                  viewportBuilder: (context, offset) {
                    return SelectableText(
                      SettingsService.to.privacyStatement.value!,
                      textAlign: TextAlign.justify,
                      style: const TextStyle(
                        fontSize: kSummaryFontSize,
                        fontWeight: FontWeight.w300,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
