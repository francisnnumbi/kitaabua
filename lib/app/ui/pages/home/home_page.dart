import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:kitaabua/app/services/dictionary_service.dart';
import 'package:kitaabua/app/ui/widgets/expression_search_view.dart';
import 'package:kitaabua/app/ui/widgets/subtitle_block.dart';
import 'package:kitaabua/core/configs/sizes.dart';

import '../../../../core/configs/themes.dart';
import '../../widgets/app_bar_header.dart';
import '../../widgets/botto_nav_bar.dart';
import '../../widgets/recent_views.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static const String route = "/";

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness:
            Themes.isDark ? Brightness.light : Brightness.dark,
      ),
    );
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      /*   appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        elevation: 0,
        title: Text(
          Utils.getCurrentDictionaryTitle(),
          style: TextStyle(
            color: Theme.of(context).colorScheme.onBackground,
            fontSize: kFooterFontSize,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),*/
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
          child: Column(
            children: [
              AppBarHeader(
                title: 'Dictionary'.tr,
              ),
              const SizedBox(height: kSizeBoxM),
              ExpressionSearchView(
                isFakeSearch: true,
              ),
              const SizedBox(height: kSizeBoxM),
              SubtitleBlock(
                icon: Icons.history,
                title: "Recent".tr,
              ),
              const Expanded(child: RecentViews()),
            ],
          ),
        ),
      ),
      floatingActionButton: !DictionaryService.to.canManageDictionary()
          ? null
          : FloatingActionButton(
              backgroundColor: Theme.of(context).colorScheme.onBackground,
              foregroundColor: Theme.of(context).colorScheme.background,
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
