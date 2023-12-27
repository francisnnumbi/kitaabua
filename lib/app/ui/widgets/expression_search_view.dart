import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kitaabua/app/services/dictionary_service.dart';
import 'package:kitaabua/app/ui/pages/dictionary/dictionary_page.dart';
import 'package:kitaabua/core/configs/sizes.dart';
import 'package:kitaabua/core/configs/utils.dart';

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
      onTapOutside: (value) {
        Utils.hideKeyboard(context);
      },
      style: TextStyle(
        color: Colors.black38,
        fontSize: Theme.of(context).textTheme.bodyLarge!.fontSize,
      ),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(
          vertical: kPaddingM,
        ),
        hintText: '${'Search expression'.tr}...',
        hintStyle: const TextStyle(
          color: Colors.grey,
        ),
        prefixIcon: const Icon(
          Icons.search,
          // color: kGreyColor,
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
            //  color: kGreyColor,
            iconSize: 20,
          );
        }),
        filled: true,
        //  fillColor: kDarkBackgroundColor,
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
