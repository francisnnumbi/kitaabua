import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kitaabua/app/controllers/members_controller.dart';
import 'package:kitaabua/app/services/auth_service.dart';
import 'package:kitaabua/app/ui/widgets/snack.dart';
import 'package:kitaabua/database/models/expression.dart';
import 'package:kitaabua/main.dart';

import '../../core/configs/dictionaries.dart';
import '../../core/configs/sizes.dart';
import '../../database/api/firebase_api.dart';
import '../ui/pages/add_edit/add_edit_page.dart';

class DictionaryService extends GetxService {
  // ------- static methods ------- //
  static DictionaryService get to => Get.find();

  static Future<void> init() async {
    await Get.putAsync<DictionaryService>(() async => DictionaryService());
  }

// ------- ./static methods ------- //
  final TextEditingController wordEC = TextEditingController();

  final Rxn<Expression> expression = Rxn<Expression>();
  final RxList<Expression> expressions = <Expression>[].obs;
  final RxList<Expression> recentExpressions = <Expression>[].obs;
  final RxList<String> wordExpressions = <String>[].obs;
  final RxList<String> similarWords = <String>[].obs;
  final RxList<Expression> similarExpressions = <Expression>[].obs;

  final RxString searchQuery = ''.obs;

  bool canManageDictionary() {
    return AuthService.to.isLoggedIn.value &&
        MembersController.to.currentMember.value != null;
  }

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

  bool wordExists(String word) {
    return expressions.firstWhereOrNull(
          (element) => element.word.toLowerCase() == word.toLowerCase(),
        ) !=
        null;
  }

  void fetchSimilarExpressions(String keyword) {
    similarExpressions.value = keyword.isEmpty
        ? []
        : expressions
            .where(
              (element) => element.word.toLowerCase().startsWith(
                    keyword.toLowerCase(),
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

  void refreshExpressions() {
    initializeBindings();
  }

  openExpression({Expression? expression, bool off = false}) async {
    this.expression.value = expression;
    if (expression != null) {
      wordEC.text = expression.word;
    } else {
      wordEC.text = "";
    }
    if (off) {
      Get.offNamed(AddEditPage.route);
    } else {
      Get.toNamed(AddEditPage.route);
    }
  }

  Future<void> addExpression({
    required String word,
  }) async {
    if (expression.value != null) {
      Expression express = Expression(
        id: expression.value!.id,
        word: word,
        addedBy: expression.value!.addedBy,
        addedOn: expression.value!.addedOn,
        state: expression.value!.state,
      );
      FirebaseApi.updateExpression(express).then((value) {
        //Get.back();
        Snack.success('Expression updated successfully'.tr);
      }).catchError((onError) {
        Snack.error('Expression update failed'.tr);
      });
    } else {
      FirebaseApi.createExpression(word: word).then((value) {
        //  Get.back();
        Snack.success('Expression added successfully'.tr);
      }).catchError((onError) {
        Snack.error('Expression add failed'.tr);
      });
    }

    //expressions.value = await FirebaseApi.readExpressions();
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
    InnerStorage.listenKey('dictionary', (value) {
      clearBindings();
      if (value == Dictionaries.FRENCH) {
        expressions.bindStream(FirebaseApi.readExpressions());
      } else if (value == Dictionaries.KITAABUA) {
        expressions.bindStream(FirebaseApi.readExpressions());
      }
    });


    expressions.listen((p0) {
      if (p0.isNotEmpty) {
        p0.sort((a, b) {
          return a.word.toLowerCase().compareTo(b.word.toLowerCase());
        });
        for (int i = 0; i < p0.length; i++) {
          wordExpressions.add(p0[i].word);
        }
        // if (kDebugMode) print(wordExpressions);
        recentExpressions.value = p0.reversed.take(5).toList();
      }
    });
  }
}
