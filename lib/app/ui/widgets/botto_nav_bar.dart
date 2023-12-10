import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kitaabua/app/ui/pages/bookmarks/bookmarks_page.dart';
import 'package:kitaabua/app/ui/pages/dictionary/dictionary_page.dart';
import 'package:kitaabua/app/ui/pages/home/home_page.dart';

import '../../../core/configs/colors.dart';
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
    ;
    return BottomNavigationBar(
      backgroundColor: kBackgroundColor,
      selectedItemColor: kOnSecondaryColor,
      unselectedItemColor: kGreyColor,
      currentIndex: cIndex,
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
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: "Home",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.menu_book_outlined),
          label: "Dictionary",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.book_outlined),
          label: "Bookmarks",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: "Settings",
        ),
      ],
    );
  }
}
