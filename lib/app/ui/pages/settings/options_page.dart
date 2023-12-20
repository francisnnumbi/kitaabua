import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kitaabua/app/services/settings_service.dart';
import 'package:kitaabua/app/ui/widgets/dialogs/options_dialogs.dart';
import 'package:kitaabua/core/configs/themes.dart';

import '../../../../core/configs/sizes.dart';
import '../../widgets/app_bar_header.dart';

class OptionsPage extends StatelessWidget {
  const OptionsPage({super.key});

  static const String route = "/settings/options";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: kBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 40, 16, 0),
        child: Column(
          children: [
            AppBarHeader(
              hasBackButton: true,
              icon: Icons.settings,
              title: "Options".tr,
              titleFontSize: kSubTitleFontSize,
              onPressed: () {},
            ),
            const SizedBox(height: kSizeBoxM),
            Expanded(
                child: ListView(
              children: [
                ListTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  title: Text(
                    "${SettingsService.to.getThemeMode().capitalizeFirst} Mode"
                        .tr,
                    // style: const TextStyle(color: kOnBackgroundColor),
                  ),
                  subtitle: Text(
                    "Manage your theme mode".tr,
                    //  style: const TextStyle(color: kGreyColor),
                  ),
                  leading: Icon(
                    SettingsService.to.getThemeMode() == Themes.LIGHT
                        ? Icons.light_mode
                        : SettingsService.to.getThemeMode() == Themes.DARK
                            ? Icons.dark_mode
                            : Icons.phone_android,
                    //  color: kGreyColor,
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    SettingsService.to.openThemeSelectDialog();
                  },
                ),
                const SizedBox(height: kSizeBoxS),
                ListTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  title: Text.rich(
                    TextSpan(
                      text: "Language".tr,
                      children: [
                        const TextSpan(
                          text: " ( ",
                          style: TextStyle(
                            //   color: kGreyColor,
                            fontSize: kSummaryFontSize,
                          ),
                        ),
                        TextSpan(
                          text: "${SettingsService.to.locale.value!['name']}",
                          style: const TextStyle(
                            //   color: kGreyColor,
                            fontSize: kSummaryFontSize,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        const TextSpan(
                          text: " )",
                          style: TextStyle(
                            //  color: kGreyColor,
                            fontSize: kSummaryFontSize,
                          ),
                        ),
                      ],
                      // style: const TextStyle(color: kOnBackgroundColor),
                    ),
                  ),
                  subtitle: Text(
                    "Manage your language".tr,
                    //style: const TextStyle(color: kGreyColor),
                  ),
                  leading: const Icon(
                    Icons.language,
                    //      color: kGreyColor,
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    openLanguageSettingsDialog();
                  },
                ),
                /*    ListTile(
                  title: const Text("Font Size",
                      style: TextStyle(color: kOnBackgroundColor)),
                  subtitle: const Text("Manage your font size",
                      style: TextStyle(color: kGreyColor)),
                  leading: const Icon(Icons.font_download, color: kGreyColor),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {},
                ),*/
                /*    ListTile(
                  title: const Text("Font Family",
                      style: TextStyle(color: kOnBackgroundColor)),
                  subtitle: const Text("Manage your font family",
                      style: TextStyle(color: kGreyColor)),
                  leading: const Icon(Icons.font_download, color: kGreyColor),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {},
                ),*/
                /*  ListTile(
                  title: const Text("Font Color",
                      style: TextStyle(color: kOnBackgroundColor)),
                  subtitle: const Text("Manage your font color",
                      style: TextStyle(color: kGreyColor)),
                  leading: const Icon(Icons.color_lens, color: kGreyColor),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {},
                ),*/
                /* ListTile(
                  title: const Text("Font Background Color",
                      style: TextStyle(color: kOnBackgroundColor)),
                  subtitle: const Text("Manage your font background color",
                      style: TextStyle(color: kGreyColor)),
                  leading: const Icon(Icons.color_lens, color: kGreyColor),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {},
                ),*/
              ],
            )),
          ],
        ),
      ),
    );
  }
}
