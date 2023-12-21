import 'package:flutter/material.dart';
import 'package:kitaabua/app/controllers/bookmarks_controller.dart';
import 'package:kitaabua/app/controllers/members_controller.dart';
import 'package:kitaabua/app/services/dictionary_service.dart';
import 'package:kitaabua/database/models/expression.dart';

import '../../../core/configs/sizes.dart';

class SearchedCard extends StatelessWidget {
  const SearchedCard({
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
      dense: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(kBorderRadiusS),
      ),
      title: Text(
        expression.word,
        overflow: TextOverflow.ellipsis,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: kPaddingS),
      trailing: !MembersController.to.isLoggedIn
          ? null
          : IconButton(
              onPressed: () {
                BookmarksController.to.toggleBookmark(expression: expression);
              },
              icon: Icon(
                Icons.bookmark_add,
                color: expression.isBookmarked!
                    ? Theme.of(context).colorScheme.error
                    : Theme.of(context).colorScheme.primary,
              ),
            ),
    );
  }
}
