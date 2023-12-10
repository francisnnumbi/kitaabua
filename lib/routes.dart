import 'package:get/get.dart';
import 'package:kitaabua/app/ui/pages/add_edit/add_edit_page.dart';
import 'package:kitaabua/app/ui/pages/home/home_page.dart';

class Routes {
  static List<GetPage> routes = [
    GetPage(
      name: HomePage.route,
      transitionDuration: const Duration(seconds: 1),
      transition: Transition.fadeIn,
      page: () => const HomePage(),
      /* middlewares: [
  AuthMiddleware(priority: -1),
  ],*/
    ),
    GetPage(
      name: AddEditPage.route,
      transitionDuration: const Duration(seconds: 1),
      transition: Transition.fadeIn,
      page: () => AddEditPage(),
      /* middlewares: [
  AuthMiddleware(priority: -1),
  ],*/
    ),
  ];
}
