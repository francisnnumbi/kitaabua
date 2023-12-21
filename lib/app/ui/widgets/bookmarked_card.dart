import 'package:flutter/material.dart';
import 'package:kitaabua/database/models/bookmark.dart';

import '../../../core/configs/sizes.dart';
import '../../controllers/bookmarks_controller.dart';
import '../../controllers/members_controller.dart';

class BookmarkedCard extends StatelessWidget {
  const BookmarkedCard({
    super.key,
    required this.bookmark,
  });

  final Bookmark bookmark;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      title: Text(
        bookmark.expression!.word,
        overflow: TextOverflow.ellipsis,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: kPaddingS),
      trailing: !MembersController.to.isLoggedIn
          ? null
          : IconButton(
              onPressed: () {
                BookmarksController.to
                    .toggleBookmark(expression: bookmark.expression!);
              },
              icon: Icon(Icons.bookmark_add,
                  color: Theme.of(context).colorScheme.error),
            ),
    );
  }
}
