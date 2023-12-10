import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:kitaabua/app/controllers/members_controller.dart';
import 'package:kitaabua/app/services/dictionary_service.dart';
import 'package:kitaabua/app/ui/pages/home/home_page.dart';
import 'package:kitaabua/core/configs/constants.dart';
import 'package:kitaabua/routes.dart';

import 'app/services/auth_service.dart';
import 'firebase_options.dart';
import 'package:get_storage/get_storage.dart';

final GetStorage InnerStorage = GetStorage(kAppName);

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
  await AuthService.init();
  await DictionaryService.init();
}

Future<void> _initControllers() async {
  await MembersController.init();
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
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: HomePage.route,
      getPages: Routes.routes,
    );
  }
}
