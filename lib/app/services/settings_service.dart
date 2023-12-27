import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kitaabua/app/ui/widgets/snack.dart';
import 'package:kitaabua/core/configs/themes.dart';
import 'package:kitaabua/main.dart';

import '../../core/configs/sizes.dart';
import '../../core/lang/locales.dart';

class SettingsService extends GetxService {
  // ------- static methods ------- //
  static SettingsService get to => Get.find();

  get isDark2 => InnerStorage.read('themeMode') == Themes.DARK;

  get isDark => {
        Themes.LIGHT: false,
        Themes.DARK: true,
        Themes.SYSTEM: Get.isPlatformDarkMode,
      }[InnerStorage.read('themeMode') ?? Themes.LIGHT]!;

  static Future<void> init() async {
    await Get.putAsync<SettingsService>(() async => SettingsService());
  }

  final Rxn<Map<String, String>> locale = Rxn<Map<String, String>>();
  final Rxn<List<Map<String, String>>> locales =
      Rxn<List<Map<String, String>>>();

  // ------- public methods ------- //
  void setLocale(Map<String, String> lang) {
    locale.value = lang;
    InnerStorage.write('lang', lang);
    final langie = lang['code']!.split("_");
    Get.updateLocale(Locale(langie[0], langie[1]));
    Get.back();
    Snack.success("Language changed to".trParams({'lang': lang['name']!}));
  }

  void setThemeMode(String themeMode, {bool? canBack = false}) {
    InnerStorage.write('themeMode', themeMode);
    switch (themeMode) {
      case Themes.LIGHT:
        Get.changeThemeMode(ThemeMode.light);
      case Themes.DARK:
        Get.changeThemeMode(ThemeMode.dark);
      case Themes.SYSTEM:
        Get.changeThemeMode(ThemeMode.system);
      default:
        Get.changeThemeMode(ThemeMode.light);
    }
    if (canBack == true) Get.back();
  }

  void openThemeSelectDialog() {
    Get.defaultDialog(
      title: "Select Theme Mode".tr,
      content: Column(
        children: [
          ListTile(
            title: Text("Light".tr),
            leading: const Icon(Icons.light_mode),
            onTap: () => setThemeMode(Themes.LIGHT, canBack: true),
            selected: getThemeMode() == Themes.LIGHT,
          ),
          const SizedBox(height: kSizeBoxS),
          ListTile(
            title: Text("Dark".tr),
            leading: const Icon(Icons.dark_mode),
            onTap: () => setThemeMode(Themes.DARK, canBack: true),
            selected: getThemeMode() == Themes.DARK,
          ),
          const SizedBox(height: kSizeBoxS),
          ListTile(
            title: Text("System".tr),
            leading: const Icon(Icons.phone_android),
            onTap: () => setThemeMode(Themes.SYSTEM, canBack: true),
            selected: getThemeMode() == Themes.SYSTEM,
          ),
        ],
      ),
    );
  }

  String getThemeMode() {
    return InnerStorage.read('themeMode') ?? Themes.LIGHT;
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    locales.value = Locales()
        .labels
        .entries
        .map((e) => {
              'name': e.value,
              'code': e.key,
            })
        .toList();

    final lali = InnerStorage.read('lang')?['code'] ?? 'en_US';
    locale.value = locales.value!.firstWhere(
      (element) => element['code'] == lali,
      orElse: () => locales.value!.first,
    );
  }
}
