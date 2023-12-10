import 'package:get/get.dart';
import 'package:kitaabua/app/services/dictionary_service.dart';

import '../../database/api/firebase_api.dart';
import '../../database/models/bookmark.dart';
import '../../database/models/expression.dart';

class BookmarksController extends GetxController {
  // ------- static methods ------- //
  static BookmarksController get to => Get.find();

  static Future<void> init() async {
    await Get.putAsync<BookmarksController>(() async => BookmarksController());
  }

// ------- ./static methods ------- //

  final RxList<Bookmark> bookmarks = <Bookmark>[].obs;
  final Rxn<Bookmark> bookmark = Rxn<Bookmark>();

  void selectBookmark(Bookmark bookmark) {
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

  void addBookmark({
    required String expressionId,
  }) {
    FirebaseApi.createBookmark(
      expressionId: expressionId,
    ).then((value) async {
      Get.snackbar('Success', 'Bookmark added successfully');
    }).catchError((onError) {
      Get.snackbar('Error', onError.toString());
    });
  }

  void deleteBookmark(Bookmark bookmark) {
    FirebaseApi.deleteBookmark(bookmark).then((value) async {
      Get.snackbar('Success', 'Bookmark deleted successfully');
    }).catchError((onError) {
      Get.snackbar('Error', onError.toString());
    });
  }

  Future<void> initializeBindings() async {
    bookmarks.bindStream(FirebaseApi.readBookmarks());
  }

  @override
  void onReady() {
    super.onReady();
    initializeBindings();
  }
}
