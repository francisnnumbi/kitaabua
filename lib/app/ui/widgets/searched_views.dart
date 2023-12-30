import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kitaabua/app/services/dictionary_service.dart';
import 'package:kitaabua/app/ui/widgets/searched_card.dart';
import 'package:kitaabua/core/configs/sizes.dart';
import 'package:kitaabua/database/models/expression.dart';

class SearchedViews extends StatelessWidget {
  const SearchedViews({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return DictionaryService.to.filteredExpressions.isEmpty
          ? Center(
              child: Text(
                'No expressions found, please search again !'.tr,
                style: const TextStyle(
                  fontSize: kHeadingFontSize,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(0),
              physics: const BouncingScrollPhysics(),
              itemCount: DictionaryService.to.filteredExpressions.length,
              itemBuilder: (context, index) {
                Expression expression =
                    DictionaryService.to.filteredExpressions[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: kPaddingS),
                  child: SearchedCard(
                    expression: expression,
                  ),
                );
              },
            );
    });
  }
}
