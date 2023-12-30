import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kitaabua/app/services/dictionary_service.dart';
import 'package:kitaabua/app/ui/widgets/view_card.dart';
import 'package:kitaabua/core/configs/sizes.dart';
import 'package:kitaabua/database/models/expression.dart';

class RecentViews extends StatelessWidget {
  const RecentViews({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return DictionaryService.to.recentExpressions.isEmpty
          ? Center(
              child: Text(
                'No recent expressions found !'.tr,
                style: const TextStyle(
                  fontSize: kHeadingFontSize,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(0),
              physics: const BouncingScrollPhysics(),
              itemCount: DictionaryService.to.recentExpressions.length,
              itemBuilder: (context, index) {
                Expression expression =
                    DictionaryService.to.recentExpressions[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: kPaddingS),
                  child: ViewCard(
                    expression: expression,
                  ),
                );
              },
            );
    });
  }
}
