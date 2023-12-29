import 'package:get/get.dart';
import 'package:kitaabua/app/services/dictionary_service.dart';

import '../../database/api/firebase_api.dart';
import '../../database/models/expression.dart';

class BookmarksController extends GetxController {
  // ------- static methods ------- //
  static BookmarksController get to => Get.find();

  static Future<void> init() async {
    await Get.putAsync<BookmarksController>(() async => BookmarksController());
  }

// ------- ./static methods ------- //

  final RxList<Expression> bookmarks = <Expression>[].obs;
  final Rxn<Expression> bookmark = Rxn<Expression>();

  void selectBookmark(Expression bookmark) {
    this.bookmark.value = bookmark;
  }

  void toggleBookmark({required Expression expression}) {
    FirebaseApi.toggleBookmark(expression).then((value) async {
      DictionaryService.to.refreshExpressions();
      // Get.snackbar('Success', 'Bookmark toggled successfully');
    }).catchError((onError) {
      // Get.snackbar('Error', onError.toString());
    });
  }

  /* void addBookmark({
    required String expressionId,
  }) {
    FirebaseApi.createBookmark(
      expressionId: expressionId,
    ).then((value) async {
      Snack.success('Bookmark added successfully'.tr);
    }).catchError((onError) {
      Snack.error(onError.toString());
    });
  }*/

/*  void deleteBookmark(Expression bookmark) {
    FirebaseApi.deleteBookmark(bookmark, bookmark.id)
        .then((value) async {
      Snack.success('Bookmark deleted successfully'.tr);
    }).catchError((onError) {
      Snack.error(onError.toString());
    });
  }*/

  Future<void> initializeBindings() async {
    //bookmarks.bindStream(FirebaseApi.readBookmarks());
    DictionaryService.to.expressions.listen((expressions) {
      bookmarks.value =
          expressions.where((element) => element.isBookmarked == true).toList();
    });
  }

  @override
  void onReady() {
    super.onReady();
    initializeBindings();
    //FirebaseApi.readBookmarks();
  }
}
