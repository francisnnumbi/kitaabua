import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kitaabua/app/ui/widgets/bookmarked_views.dart';
import 'package:kitaabua/core/configs/sizes.dart';

import '../../widgets/botto_nav_bar.dart';
import '../../widgets/simple_app_bar_header.dart';

class BookmarksPage extends StatelessWidget {
  const BookmarksPage({super.key});

  static const String route = "/bookmarks";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 40, 16, 0),
        child: Column(
          children: [
            SimpleAppBarHeader(
              icon: Icons.bookmark_outline,
              title: "Bookmarks".tr,
              titleFontSize: kSubTitleFontSize,
            ),
            const SizedBox(height: kSizeBoxM),
            const Expanded(child: BookmarkedViews()),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}
