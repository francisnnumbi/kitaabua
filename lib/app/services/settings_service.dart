import 'dart:ui';

import 'package:get/get.dart';
import 'package:kitaabua/app/ui/widgets/snack.dart';
import 'package:kitaabua/main.dart';

import '../../core/lang/locales.dart';

class SettingsService extends GetxService {
  // ------- static methods ------- //
  static SettingsService get to => Get.find();

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

    final lali = InnerStorage.read('lang');
    locale.value = locales.value!.firstWhere(
      (element) => element['code'] == lali['code'],
      orElse: () => locales.value!.first,
    );
  }
}
