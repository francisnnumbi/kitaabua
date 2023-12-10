import 'package:flutter/material.dart';
import 'package:kitaabua/app/services/dictionary_service.dart';
import 'package:kitaabua/app/ui/widgets/expression_search_view.dart';
import 'package:kitaabua/app/ui/widgets/searched_views.dart';
import 'package:kitaabua/core/configs/colors.dart';
import 'package:kitaabua/core/configs/sizes.dart';

import '../../widgets/botto_nav_bar.dart';
import '../../widgets/simple_app_bar_header.dart';

class DictionaryPage extends StatelessWidget {
  const DictionaryPage({super.key});

  static const String route = "/dictionary";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 40, 16, 0),
        child: Column(
          children: [
            const SimpleAppBarHeader(
              icon: Icons.menu_book_outlined,
              title: "Dictionary",
              titleFontSize: kSubTitleFontSize,
            ),
            const SizedBox(height: kSizeBoxM),
            ExpressionSearchView(),
            const SizedBox(height: kSizeBoxS),
            const Expanded(child: SearchedViews()),
          ],
        ),
      ),
      floatingActionButton: !DictionaryService.to.canManageDictionary()
          ? null
          : FloatingActionButton(
              backgroundColor: kDarkBackgroundColor,
              foregroundColor: kOnBackgroundColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(kBorderRadius),
              ),
              elevation: 10,
              onPressed: () {
                DictionaryService.to.openExpression();
              },
              child: const Icon(
                Icons.add,
                size: kSizeBoxXL,
              ),
            ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}