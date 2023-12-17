import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kitaabua/app/services/settings_service.dart';

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
    title: "Language",
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
          decoration: const InputDecoration(
            labelText: 'Select Language',
            labelStyle: TextStyle(
              color: kOnBackgroundColor,
            ),
            hintStyle: TextStyle(
              color: kOnBackgroundColor,
            ),
            filled: true,
            fillColor: kGreyColor,
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent),
              borderRadius: BorderRadius.all(
                Radius.circular(kBorderRadiusS),
              ),
            ),
            enabledBorder: OutlineInputBorder(
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
