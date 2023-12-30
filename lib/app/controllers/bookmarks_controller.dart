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
  final RxBool isBookmarking = false.obs;

  void selectBookmark(Expression bookmark) {
    this.bookmark.value = bookmark;
  }

  void toggleBookmark({required Expression expression}) {
    bookmark.value = expression;
    isBookmarking.value = true;
    FirebaseApi.toggleBookmark(expression).then((value) async {
      DictionaryService.to.refreshExpressions();
      Get.snackbar('Success', 'Bookmark toggled successfully');
    }).catchError((onError) {
      Get.snackbar('Error', onError.toString());
    }).whenComplete(
      () {
        isBookmarking.value = false;
      },
    );
  }

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
