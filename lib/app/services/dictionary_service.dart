import 'package:get/get.dart';
import 'package:kitaabua/database/models/expression.dart';

import '../../database/api/firebase_api.dart';
import '../ui/pages/add_edit/add_edit_page.dart';

class DictionaryService extends GetxService {
  // ------- static methods ------- //
  static DictionaryService get to => Get.find();

  static Future<void> init() async {
    await Get.putAsync<DictionaryService>(() async => DictionaryService());
  }

// ------- ./static methods ------- //

  final RxList<Expression> expressions = <Expression>[].obs;
  final RxList<Expression> recentExpressions = <Expression>[].obs;
  final RxList<Expression> favoriteExpressions = <Expression>[].obs;

  final Rxn<Expression> expression = Rxn<Expression>();
  final RxString searchQuery = ''.obs;

  List<Expression> get filteredExpressions {
    return searchQuery.isEmpty
        ? []
        : expressions
            .where(
              (Expression expression) => expression.word.toLowerCase().contains(
                    searchQuery.value.toLowerCase(),
                  ),
            )
            .toList();
  }

  void filterExpressions(String query) {
    searchQuery.value = query.trim();
    expressions.refresh();
  }

  void clearFilterExpressions() {
    searchQuery.value = '';
    expressions.refresh();
  }

  openExpression({Expression? expression}) async {
    this.expression.value = expression;
    Get.toNamed(AddEditPage.route);
  }

  void addExpression({
    required String word,
  }) {
    FirebaseApi.createExpression(word: word).then((value) {
      Get.back();
      Get.snackbar('Success', 'Expression added successfully');
    }).catchError((onError) {
      Get.snackbar('Error', onError.toString());
    });
  }

  Future<void> initializeBindings() async {
    expressions.bindStream(FirebaseApi.readExpressions());
  }

  Future<void> clearBindings() async {
    expressions.clear();
  }

  Future<void> dispose() async {
    await clearBindings();
    await Get.delete<DictionaryService>(force: true);
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    initializeBindings();
  }
}
