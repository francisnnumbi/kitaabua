import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kitaabua/database/models/expression.dart';

import '../../../core/configs/sizes.dart';
import '../../controllers/bookmarks_controller.dart';
import '../../controllers/members_controller.dart';

class BookmarkedCard extends StatelessWidget {
  const BookmarkedCard({
    super.key,
    required this.bookmark,
  });

  final Expression bookmark;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      title: Text(
        bookmark.word ?? '',
        overflow: TextOverflow.ellipsis,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: kPaddingS),
      trailing: !MembersController.to.isLoggedIn
          ? null
          : Obx(() {
              return BookmarksController.to.isBookmarking.value &&
                      BookmarksController.to.bookmark.value!.id == bookmark.id
                  ? SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        color: Theme.of(context).colorScheme.error,
                      ),
                    )
                  : IconButton(
                      onPressed: () {
                        BookmarksController.to
                            .toggleBookmark(expression: bookmark);
                      },
                      icon: Icon(
                        Icons.bookmark_add,
                        color: Theme.of(context).colorScheme.error,
                      ),
                    );
            }),
    );
  }
}
