import 'package:flutter/material.dart';
import 'package:kitaabua/app/services/dictionary_service.dart';
import 'package:kitaabua/database/models/expression.dart';

import '../../../core/configs/colors.dart';
import '../../../core/configs/sizes.dart';

class ViewCard extends StatelessWidget {
  const ViewCard({
    super.key,
    required this.expression,
  });

  final Expression expression;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        DictionaryService.to.openExpression(expression: expression);
      },
      tileColor: kDarkBackgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(kBorderRadiusS),
      ),
      dense: true,
      isThreeLine: false,
      title: RichText(
        text: TextSpan(
          text: expression.word,
          style: TextStyle(
            color: kOnBackgroundColor,
            fontWeight: FontWeight.bold,
            fontSize: Theme.of(context).textTheme.bodyLarge!.fontSize,
          ),
          children: <TextSpan>[
            TextSpan(
              text: " - ",
              style: TextStyle(
                color: kOnBackgroundColor,
                fontWeight: FontWeight.normal,
                fontSize: Theme.of(context).textTheme.bodySmall!.fontSize,
              ),
            ),
            TextSpan(
              text: expression.addedBy,
              style: TextStyle(
                color: kOnBackgroundColor,
                fontWeight: FontWeight.normal,
                fontSize: Theme.of(context).textTheme.labelSmall!.fontSize,
              ),
            ),
          ],
        ),
      ),
      contentPadding:
          const EdgeInsets.symmetric(horizontal: kPaddingS, vertical: 0),
    );
  }
}
