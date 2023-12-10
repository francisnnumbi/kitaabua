import 'package:flutter/material.dart';
import 'package:kitaabua/app/ui/widgets/view_card.dart';
import 'package:kitaabua/core/configs/sizes.dart';
import 'package:kitaabua/database/models/expression.dart';

class RecentViews extends StatelessWidget {
  const RecentViews({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: Expression.sampleList().length,
      itemBuilder: (context, index) {
        Expression expression = Expression.sampleList()[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: kPaddingS),
          child: ViewCard(
            expression: expression,
          ),
        );
      },
    );
  }
}
