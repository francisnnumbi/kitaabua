import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kitaabua/app/controllers/bookmarks_controller.dart';
import 'package:kitaabua/app/controllers/meanings_controller.dart';
import 'package:kitaabua/app/controllers/members_controller.dart';
import 'package:kitaabua/app/services/dictionary_service.dart';
import 'package:kitaabua/app/services/settings_service.dart';
import 'package:kitaabua/app/ui/pages/home/home_page.dart';
import 'package:kitaabua/core/configs/constants.dart';
import 'package:kitaabua/routes.dart';

import 'app/services/auth_service.dart';
import 'core/lang/locales.dart';
import 'firebase_options.dart';

final GetStorage InnerStorage = GetStorage(kAppName);

Locale _initLang() {
  return Locales.getStoredLocale();
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init(kAppName);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await initServices();
  runApp(MainApp());
}

Future<void> initServices() async {
  await SettingsService.init();
  await AuthService.init();
  await DictionaryService.init();
}

Future<void> _initControllers() async {
  await MembersController.init();
  await MeaningsController.init();
  await BookmarksController.init();
}

class MainApp extends StatelessWidget {
  MainApp({super.key}) {
    _initControllers();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
    );
    return GetMaterialApp(
      title: kAppName,
      debugShowCheckedModeBanner: false,
      translations: Locales(),
      locale: _initLang(),
      fallbackLocale: const Locale('fr', 'FR'),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        primaryTextTheme: GoogleFonts.tekoTextTheme(
          Theme.of(context).textTheme,
        ),
        textTheme: GoogleFonts.tekoTextTheme(
          Theme.of(context).textTheme,
          /*.copyWith(
                bodyLarge: const TextStyle(fontSize: 12.0),
                bodyMedium: const TextStyle(fontSize: 10.0),
                bodySmall: const TextStyle(fontSize: 8.0),
                labelLarge: const TextStyle(fontSize: 12.0),
                labelMedium: const TextStyle(fontSize: 10.0),
                labelSmall: const TextStyle(fontSize: 8.0),
                headlineLarge: const TextStyle(fontSize: 18.0),
                headlineMedium: const TextStyle(fontSize: 16.0),
                headlineSmall: const TextStyle(fontSize: 14.0),
              ),*/
        ),
      ),
      initialRoute: HomePage.route,
      getPages: Routes.routes,
    );
  }
}
