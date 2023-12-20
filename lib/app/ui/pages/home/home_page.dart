import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kitaabua/app/services/dictionary_service.dart';
import 'package:kitaabua/app/ui/widgets/expression_search_view.dart';
import 'package:kitaabua/app/ui/widgets/subtitle_block.dart';
import 'package:kitaabua/core/configs/colors.dart';
import 'package:kitaabua/core/configs/sizes.dart';

import '../../widgets/app_bar_header.dart';
import '../../widgets/botto_nav_bar.dart';
import '../../widgets/recent_views.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static const String route = "/";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //  backgroundColor: kBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
          child: Column(
            children: [
              const AppBarHeader(),
              const SizedBox(height: kSizeBoxM),
              ExpressionSearchView(
                isFakeSearch: true,
              ),
              const SizedBox(height: kSizeBoxM),
              SubtitleBlock(
                icon: Icons.history,
                title: "Recent".tr,
                // titleFontSize: kHeadingFontSize,
              ),
              const Expanded(child: RecentViews()),
            ],
          ),
        ),
      ),
      floatingActionButton: !DictionaryService.to.canManageDictionary()
          ? null
          : FloatingActionButton(
              mini: true,
              backgroundColor: kDarkBackgroundColor,
              foregroundColor: kOnBackgroundColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(kBorderRadius),
              ),
              elevation: 10,
              onPressed: () {
                DictionaryService.to.openExpression(expression: null);
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
