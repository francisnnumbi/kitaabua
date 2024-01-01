import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:get/get.dart';
import 'package:kitaabua/app/ui/widgets/snack.dart';
import 'package:kitaabua/core/configs/dictionaries.dart';
import 'package:kitaabua/core/configs/themes.dart';
import 'package:kitaabua/main.dart';

import '../../core/configs/sizes.dart';
import '../../core/lang/locales.dart';
import '../../generated/assets.dart';

class SettingsService extends GetxService {
  // ------- static methods ------- //
  static SettingsService get to => Get.find();

  get isDark2 => InnerStorage.read('themeMode') == Themes.DARK;

/*  get isDark => {
        Themes.LIGHT: false,
        Themes.DARK: true,
        Themes.SYSTEM: Get.isPlatformDarkMode,
      }[InnerStorage.read('themeMode') ?? Themes.LIGHT]!;*/

  static Future<void> init() async {
    await Get.putAsync<SettingsService>(() async => SettingsService());
  }

  final Rxn<Map<String, String>> locale = Rxn<Map<String, String>>();
  final Rxn<List<Map<String, String>>> locales =
      Rxn<List<Map<String, String>>>();
  final Rxn<String> privacyStatement = Rxn<String>();

  loadPrivacyStatement() async {
    privacyStatement.value =
        await rootBundle.loadString(Assets.textsPrivacyStatement);
  }

  // ------- public methods ------- //
  void setLocale(Map<String, String> lang) {
    locale.value = lang;
    InnerStorage.write('lang', lang);
    final langie = lang['code']!.split("_");
    Get.updateLocale(Locale(langie[0], langie[1]));
    Get.back();
    Snack.success("Language changed to".trParams({'lang': lang['name']!}));
  }

  void setThemeMode(String themeMode, {bool? canBack = false}) async {
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
    await InnerStorage.write('themeMode', themeMode);
    2.delay();
    if (canBack == true) 1.delay(() => Get.back());
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

  Future<void> setDictionary(String dictionary) async {
    InnerStorage.write('dictionary', dictionary);
    Get.back();
    Snack.success("Dictionary changed to".trParams({'dict': dictionary}));
  }

  Future<void> selectDictionaryDialog() async {
    await Get.defaultDialog(
      title: "Select Dictionary".tr,
      content: Column(
        children: [
          ListTile(
            title: Text(Dictionaries.FRENCH.tr),
            leading: const Icon(Icons.language),
            onTap: () {
              setDictionary(Dictionaries.FRENCH);
            },
            selected: InnerStorage.read('dictionary') == Dictionaries.FRENCH,
          ),
          const SizedBox(height: kSizeBoxS),
          ListTile(
            title: Text(Dictionaries.KITAABUA.tr),
            leading: const Icon(Icons.language),
            onTap: () {
              setDictionary(Dictionaries.KITAABUA);
            },
            selected: InnerStorage.read('dictionary') == Dictionaries.KITAABUA,
          ),
        ],
      ),
    );
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    loadPrivacyStatement();
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
