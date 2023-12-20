import 'package:flutter/material.dart';
import 'package:kitaabua/app/services/dictionary_service.dart';
import 'package:kitaabua/database/models/expression.dart';

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
      //  tileColor: kDarkBackgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(kBorderRadiusS),
      ),
      dense: true,
      isThreeLine: false,
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              expression.word,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
          Text(
            ' ( ',
            style: Theme.of(context).textTheme.labelMedium,
          ),
          Text(
            expression.addedBy,
            style: Theme.of(context).textTheme.labelMedium,
          ),
          Text(
            ' ) ',
            style: Theme.of(context).textTheme.labelMedium,
          ),
        ],
      ),
      contentPadding:
          const EdgeInsets.symmetric(horizontal: kPaddingS, vertical: 0),
    );
  }
}
