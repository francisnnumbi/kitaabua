import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kitaabua/app/controllers/bookmarks_controller.dart';
import 'package:kitaabua/app/ui/widgets/bookmarked_card.dart';
import 'package:kitaabua/core/configs/sizes.dart';
import 'package:kitaabua/database/models/bookmark.dart';

class BookmarkedViews extends StatelessWidget {
  const BookmarkedViews({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return ListView.builder(
        padding: const EdgeInsets.all(0),
        physics: const BouncingScrollPhysics(),
        itemCount: BookmarksController.to.bookmarks.length,
        itemBuilder: (context, index) {
          Bookmark bookmark = BookmarksController.to.bookmarks[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: kPaddingS),
            child: BookmarkedCard(
              bookmark: bookmark,
            ),
          );
        },
      );
    });
  }
}
