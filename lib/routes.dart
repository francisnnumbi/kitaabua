import 'package:get/get.dart';
import 'package:kitaabua/app/ui/pages/add_edit/add_edit_page.dart';
import 'package:kitaabua/app/ui/pages/auth/logins/principal_login_page.dart';
import 'package:kitaabua/app/ui/pages/auth/profile/profile_page.dart';
import 'package:kitaabua/app/ui/pages/auth/registers/guest_register_page.dart';
import 'package:kitaabua/app/ui/pages/bookmarks/bookmarks_page.dart';
import 'package:kitaabua/app/ui/pages/dictionary/dictionary_page.dart';
import 'package:kitaabua/app/ui/pages/home/home_page.dart';
import 'package:kitaabua/app/ui/pages/settings/options_page.dart';

import 'app/ui/pages/auth/logins/guest_login_page.dart';
import 'app/ui/pages/settings/settings_page.dart';

class Routes {
  static List<GetPage> routes = [
    GetPage(
      name: HomePage.route,
      // transitionDuration: const Duration(seconds: 1),
      transition: Transition.fadeIn,
      page: () => const HomePage(),
      /* middlewares: [
  AuthMiddleware(priority: -1),
  ],*/
    ),
    GetPage(
      name: DictionaryPage.route,
      // transitionDuration: const Duration(seconds: 1),
      transition: Transition.fadeIn,
      page: () => const DictionaryPage(),
      /* middlewares: [
  AuthMiddleware(priority: -1),
  ],*/
    ),
    GetPage(
      name: AddEditPage.route,
      // transitionDuration: const Duration(seconds: 1),
      transition: Transition.fadeIn,
      page: () => AddEditPage(),
      /* middlewares: [
  AuthMiddleware(priority: -1),
  ],*/
    ),
    GetPage(
      name: SettingsPage.route,
      //  transitionDuration: const Duration(seconds: 1),
      transition: Transition.fadeIn,
      page: () => const SettingsPage(),
      /* middlewares: [
  AuthMiddleware(priority: -1),
  ],*/
    ),
    GetPage(
      name: OptionsPage.route,
      //  transitionDuration: const Duration(seconds: 1),
      transition: Transition.fadeIn,
      page: () => const OptionsPage(),
      /* middlewares: [
  AuthMiddleware(priority: -1),
  ],*/
    ),
    GetPage(
      name: BookmarksPage.route,
      // transitionDuration: const Duration(seconds: 1),
      transition: Transition.fadeIn,
      page: () => const BookmarksPage(),
      /* middlewares: [
  AuthMiddleware(priority: -1),
  ],*/
    ),
    GetPage(
      name: ProfilePage.route,
      //transitionDuration: const Duration(seconds: 1),
      transition: Transition.fadeIn,
      page: () => const ProfilePage(),
      /* middlewares: [
  AuthMiddleware(priority: -1),
  ],*/
    ),
    GetPage(
      name: PrincipalLoginPage.route,
      //transitionDuration: const Duration(seconds: 1),
      transition: Transition.fadeIn,
      page: () => PrincipalLoginPage(),
      /* middlewares: [
  AuthMiddleware(priority: -1),
  ],*/
    ),
    GetPage(
      name: GuestLoginPage.route,
      //transitionDuration: const Duration(seconds: 1),
      transition: Transition.fadeIn,
      page: () => GuestLoginPage(),
      /* middlewares: [
  AuthMiddleware(priority: -1),
  ],*/
    ),
    GetPage(
      name: GuestRegisterPage.route,
      //transitionDuration: const Duration(seconds: 1),
      transition: Transition.fadeIn,
      page: () => GuestRegisterPage(),
      /* middlewares: [
  AuthMiddleware(priority: -1),
  ],*/
    ),
  ];
}
