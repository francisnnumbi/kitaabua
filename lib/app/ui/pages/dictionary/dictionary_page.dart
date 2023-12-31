import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kitaabua/app/services/dictionary_service.dart';
import 'package:kitaabua/app/ui/widgets/expression_search_view.dart';
import 'package:kitaabua/app/ui/widgets/searched_views.dart';
import 'package:kitaabua/core/configs/sizes.dart';

import '../../../../core/configs/themes.dart';
import '../../../../core/configs/utils.dart';
import '../../widgets/botto_nav_bar.dart';
import '../../widgets/simple_app_bar_header.dart';

class DictionaryPage extends StatelessWidget {
  const DictionaryPage({super.key});

  static const String route = "/dictionary";

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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
          child: Column(
            children: [
              SimpleAppBarHeader(
                icon: Icons.menu_book_outlined,
                title: Utils.getCurrentDictionaryTitle(),
                titleFontSize: kHeadingFontSize,
                actions: [
                  IconButton(
                    onPressed: !DictionaryService.to.canManageDictionary()
                        ? null
                        : () {
                            DictionaryService.to
                                .openExpression(expression: null);
                          },
                    icon: const Icon(Icons.add),
                  ),
                ],
              ),
              const SizedBox(height: kSizeBoxM),
              ExpressionSearchView(),
              const SizedBox(height: kSizeBoxM),
              const Expanded(child: SearchedViews()),
            ],
          ),
        ),
      ),
      /*    floatingActionButton: !DictionaryService.to.canManageDictionary()
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
            ),*/
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}
