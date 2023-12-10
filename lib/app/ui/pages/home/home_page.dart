import 'package:flutter/material.dart';
import 'package:kitaabua/app/ui/widgets/word_search_view.dart';
import 'package:kitaabua/core/configs/colors.dart';
import 'package:kitaabua/core/configs/sizes.dart';

import '../../widgets/app_bar_header.dart';
import '../../widgets/recent_views.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: const Padding(
        padding: EdgeInsets.fromLTRB(16, 40, 16, 0),
        child: Column(
          children: [
            AppBarHeader(),
            SizedBox(height: kSizeBoxM),
            WordSearchView(),
            SizedBox(height: kSizeBoxM),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Recent Visits',
                style: TextStyle(
                  color: kOnBackgroundColor,
                  fontSize: kHeadingFontSize,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(child: RecentViews()),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: kDarkBackgroundColor,
        foregroundColor: kOnBackgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(kBorderRadius),
        ),
        elevation: 10,
        onPressed: () {},
        child: const Icon(
          Icons.add,
          size: kSizeBoxXL,
        ),
      ),
    );
  }
}
