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
      return ListView.builder(
        itemCount: DictionaryService.to.expressions.length,
        itemBuilder: (context, index) {
          Expression expression = DictionaryService.to.expressions[index];
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
