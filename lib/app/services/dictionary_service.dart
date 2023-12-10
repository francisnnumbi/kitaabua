import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:kitaabua/app/ui/pages/add_edit/add_edit_page.dart';
import 'package:kitaabua/database/models/expression.dart';

import '../../database/api/firebase_api.dart';

class DictionaryService extends GetxService {
  // ------- static methods ------- //
  static DictionaryService get to => Get.find();

  static Future<void> init() async {
    await Get.putAsync<DictionaryService>(() async => DictionaryService());
  }

// ------- ./static methods ------- //

  final RxList<Expression> expressions = <Expression>[].obs;
  final Rxn<Expression> expression = Rxn<Expression>();
  final RxString searchQuery = ''.obs;

  List<Expression> get filteredExpressions {
    return searchQuery.value.isEmpty
        ? expressions
        : expressions
            .where(
              (Expression expression) => expression.word.toLowerCase().contains(
                    searchQuery.value.toLowerCase(),
                  ),
            )
            .toList();
  }

  openExpression({Expression? expression}) {
    this.expression.value = expression;
    Get.toNamed(AddEditPage.route);
  }

  Future<void> initializeBindings() async {
    expressions.bindStream(FirebaseApi.readExpressions());
    if (kDebugMode) print(expressions.toString());
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
