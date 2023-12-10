import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kitaabua/app/services/dictionary_service.dart';
import 'package:kitaabua/app/ui/pages/dictionary/dictionary_page.dart';
import 'package:kitaabua/core/configs/colors.dart';
import 'package:kitaabua/core/configs/sizes.dart';

class ExpressionSearchView extends StatelessWidget {
  ExpressionSearchView({super.key, this.isFakeSearch = false});

  final bool? isFakeSearch;
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextField(
      onTap: !isFakeSearch!
          ? null
          : () {
              Get.toNamed(DictionaryPage.route);
            },
      //autofocus: !isFakeSearch!,
      controller: searchController,
      onChanged: (value) {
        DictionaryService.to.filterExpressions(searchController.text);
      },
      style: const TextStyle(
        color: kOnBackgroundColor,
        fontSize: kSearchFontSize,
      ),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(
          vertical: kPaddingM,
        ),
        hintText: 'Search expression...',
        hintStyle: const TextStyle(
          color: kGreyColor,
        ),
        prefixIcon: const Icon(
          Icons.search,
          color: kGreyColor,
        ),
        suffixIcon: Obx(() {
          return IconButton(
            onPressed: DictionaryService.to.searchQuery.isEmpty
                ? null
                : () {
                    searchController.clear();
                    DictionaryService.to.clearFilterExpressions();
                  },
            icon: DictionaryService.to.searchQuery.isEmpty
                ? const SizedBox()
                : const Icon(Icons.close),
            color: kGreyColor,
            iconSize: 20,
          );
        }),
        filled: true,
        fillColor: kDarkBackgroundColor,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(kBorderRadius),
          borderSide: const BorderSide(color: Colors.transparent),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(kBorderRadius),
          borderSide: const BorderSide(color: Colors.transparent),
        ),
      ),
    );
  }
}