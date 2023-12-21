import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kitaabua/app/ui/pages/bookmarks/bookmarks_page.dart';
import 'package:kitaabua/app/ui/pages/dictionary/dictionary_page.dart';
import 'package:kitaabua/app/ui/pages/home/home_page.dart';

import '../pages/settings/settings_page.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    int cIndex = 0;
    switch (Get.currentRoute) {
      case HomePage.route:
        cIndex = 0;
      case DictionaryPage.route:
        cIndex = 1;
      case BookmarksPage.route:
        cIndex = 2;
      case SettingsPage.route:
        cIndex = 3;
      default:
        cIndex = 1;
    }
    return BottomNavigationBar(
      //  backgroundColor: kDarkBackgroundColor,
      //  selectedItemColor: kOnSecondaryColor,
      selectedFontSize: Theme.of(context).textTheme.headlineSmall!.fontSize!,
      // unselectedItemColor: kGreyColor,
      unselectedFontSize: Theme.of(context).textTheme.headlineSmall!.fontSize!,
      currentIndex: cIndex,
      // type: BottomNavigationBarType.fixed,
      onTap: (index) {
        switch (index) {
          case 0:
            Get.offAllNamed(HomePage.route);
            break;
          case 1:
            Get.offAllNamed(DictionaryPage.route);
            break;
          case 2:
            Get.offAllNamed(BookmarksPage.route);
            break;
          case 3:
            Get.offAllNamed(SettingsPage.route);
            break;
          default:
            Get.offAllNamed(DictionaryPage.route);
        }
      },
      items: [
        BottomNavigationBarItem(
          icon: const Icon(Icons.home),
          label: "Home".tr,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.menu_book_outlined),
          label: "Dictionary".tr,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.book_outlined),
          label: "Bookmarks".tr,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.settings),
          label: "Settings".tr,
        ),
      ],
    );
  }
}
