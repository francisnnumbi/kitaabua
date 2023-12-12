import 'package:flutter/material.dart';
import 'package:kitaabua/database/models/bookmark.dart';

import '../../../core/configs/colors.dart';
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
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(kBorderRadiusS),
      ),
      child: ListTile(
        title: RichText(
          text: TextSpan(
            text: bookmark.expression!.word,
            style: const TextStyle(
              color: kOnSurfaceColor,
              fontWeight: FontWeight.bold,
              fontSize: kHeadingFontSize,
              height: 1.5,
            ),
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: kPaddingS),
        trailing: !MembersController.to.isLoggedIn
            ? null
            : IconButton(
                onPressed: () {
                  BookmarksController.to
                      .toggleBookmark(expression: bookmark.expression!);
                },
                icon: const Icon(Icons.bookmark_add, color: kSuccessColor),
              ),
      ),
    );
  }
}
