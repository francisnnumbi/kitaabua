import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kitaabua/app/services/settings_service.dart';
import 'package:kitaabua/generated/assets.dart';

import '../../../../core/configs/colors.dart';
import '../../../../core/configs/sizes.dart';

openLanguageSettingsDialog() {
  final droppies = SettingsService.to.locales.value!
      .map((e) => DropdownMenuItem<Map<String, String>>(
            value: e,
            child: Text(e['name']!),
          ))
      .toList();

  Get.defaultDialog(
    title: "Language".tr,
    titleStyle: const TextStyle(
      color: kOnBackgroundColor,
      fontSize: kTitleFontSize,
    ),
    backgroundColor: kOnSurfaceColor,
    content: Column(
      children: [
        DropdownButtonFormField<Map<String, String>>(
          items: droppies,
          elevation: 0,
          value: SettingsService.to.locale.value,
          onChanged: (lang) {
            SettingsService.to.setLocale(lang!);
          },
          style: const TextStyle(
            color: kOnSurfaceColor,
            fontSize: kSearchFontSize,
          ),
          decoration: InputDecoration(
            labelText: 'Select Language'.tr,
            labelStyle: const TextStyle(
              color: kOnBackgroundColor,
            ),
            hintStyle: const TextStyle(
              color: kOnBackgroundColor,
            ),
            filled: true,
            fillColor: kGreyColor,
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
      ],
    ),
  );
}

openAboutDialog() {
  Get.defaultDialog(
    title: "About".tr,
    titleStyle: const TextStyle(
      color: kOnBackgroundColor,
      fontSize: kTitleFontSize,
    ),
    backgroundColor: kOnSurfaceColor,
    contentPadding: const EdgeInsets.all(16),
    content: Column(
      children: [
        Center(
          child: Image.asset(
            Assets.logosLogo,
            width: 80,
            height: 80,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        const Text(
          "Kitaabua is a Kitaabua-Français dictionary that helps you learn Kitaabua language. "
          "It is a free and open source project. "
          "You can contribute to the project by reporting bugs, suggesting new features, translating the app to your language or by donating to the project.",
          style: TextStyle(
            color: kOnBackgroundColor,
            fontSize: kSummaryFontSize,
          ),
          textAlign: TextAlign.justify,
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          "${"Developed by".tr} :",
          style: const TextStyle(
            color: kOnBackgroundColor,
            fontSize: kSummaryFontSize,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        const Text(
          "Francis Nduba Numbi",
          style: TextStyle(
            color: kOnBackgroundColor,
            fontSize: kSearchFontSize,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          "With love to Taabua Community".tr,
          style: const TextStyle(
            color: kOnBackgroundColor,
            fontSize: kFooterFontSize,
          ),
        ),
      ],
    ),
  );
}
