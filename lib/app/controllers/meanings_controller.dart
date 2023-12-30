import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kitaabua/app/services/dictionary_service.dart';
import 'package:kitaabua/app/ui/widgets/snack.dart';
import 'package:kitaabua/database/api/firebase_api.dart';

import '../../core/configs/sizes.dart';
import '../../database/models/expression.dart';
import '../../database/models/meaning.dart';

class MeaningsController extends GetxController {
  // ------- static methods ------- //
  static MeaningsController get to => Get.find();

  static Future<void> init() async {
    await Get.putAsync<MeaningsController>(() async => MeaningsController());
  }

// ------- ./static methods ------- //

  final RxList<Meaning> meanings = <Meaning>[].obs;
  final Rxn<Meaning> meaning = Rxn<Meaning>();
  final Rxn<Expression> expression = Rxn<Expression>();

  void selectMeaning(Meaning meaning) {
    this.meaning.value = meaning;
  }

  void addMeaning({
    required String expressionId,
    required String meaning,
    String? example,
    String? exampleTranslation,
  }) {
    FirebaseApi.createMeaning(
      expressionId: expressionId,
      meaning: meaning,
      example: example!,
      exampleTranslation: exampleTranslation!,
      grammar: 'word',
    );
  }

  addMeaningDialog({required String expressionId, VoidCallback? onAdd}) {
    final meaningFormKey = GlobalKey<FormState>();

    final meaningController = TextEditingController();
    final exampleController = TextEditingController();
    final exampleTranslationController = TextEditingController();
    Get.defaultDialog(
      title: 'Add Meaning'.tr,
      content: Form(
        key: meaningFormKey,
        child: Column(
          children: [
            TextFormField(
              controller: meaningController,
              style: const TextStyle(
                // color: kOnBackgroundColor,
                fontSize: kSearchFontSize,
              ),
              validator: (va) {
                if (va!.isEmpty) {
                  return "meaning must not be empty".tr;
                }
                return null;
              },
              decoration: InputDecoration(
                labelText: 'Meaning'.tr,
                labelStyle: const TextStyle(
                    // color: kGreyColor,
                    ),
                hintStyle: const TextStyle(
                    // color: kGreyColor,
                    ),
                filled: true,
                // fillColor: kBackgroundColor,
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                  borderRadius: BorderRadius.all(
                    Radius.circular(kBorderRadiusS),
                  ),
                ),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                  borderRadius: BorderRadius.all(
                    Radius.circular(kBorderRadiusS),
                  ),
                ),
              ),
            ),
            const SizedBox(height: kSizeBoxS),
            TextFormField(
              style: const TextStyle(
                // color: kOnBackgroundColor,
                fontSize: kSearchFontSize,
              ),
              controller: exampleController,
              decoration: InputDecoration(
                labelText: 'Example'.tr,
                labelStyle: const TextStyle(
                    // color: kGreyColor,
                    ),
                hintStyle: const TextStyle(
                    // color: kGreyColor,
                    ),
                filled: true,
                // fillColor: kBackgroundColor,
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                  borderRadius: BorderRadius.all(
                    Radius.circular(kBorderRadiusS),
                  ),
                ),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                  borderRadius: BorderRadius.all(
                    Radius.circular(kBorderRadiusS),
                  ),
                ),
              ),
            ),
            const SizedBox(height: kSizeBoxS),
            TextFormField(
              controller: exampleTranslationController,
              style: const TextStyle(
                // color: kOnBackgroundColor,
                fontSize: kSearchFontSize,
              ),
              decoration: InputDecoration(
                labelText: 'Example Translation'.tr,
                labelStyle: const TextStyle(
                    // color: kGreyColor,
                    ),
                hintStyle: const TextStyle(
                    // color: kGreyColor,
                    ),
                filled: true,
                // fillColor: kBackgroundColor,
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                  borderRadius: BorderRadius.all(
                    Radius.circular(kBorderRadiusS),
                  ),
                ),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                  borderRadius: BorderRadius.all(
                    Radius.circular(kBorderRadiusS),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
          },
          child: Text('Cancel'.tr),
        ),
        TextButton(
          onPressed: () {
            if (!meaningFormKey.currentState!.validate()) {
              return;
            }
            meaningFormKey.currentState!.save();
            MeaningsController.to.addMeaning(
              expressionId: expressionId,
              meaning: meaningController.text,
              example: exampleController.text,
              exampleTranslation: exampleTranslationController.text,
            );
            Get.back();
            Snack.success('Meaning added successfully'.tr);
            if (onAdd != null) {
              onAdd();
            }
          },
          child: Text('Add'.tr),
        ),
      ],
    );
  }

  editMeaningDialog({
    required String expressionId,
    required Meaning meaning,
    VoidCallback? onEdit,
  }) {
    final meaningFormKey = GlobalKey<FormState>();

    final meaningController = TextEditingController(text: meaning.meaning);
    final exampleController = TextEditingController(text: meaning.example);
    final exampleTranslationController =
        TextEditingController(text: meaning.exampleTranslation);
    Get.defaultDialog(
      title: 'Edit Meaning'.tr,
      content: Form(
        key: meaningFormKey,
        child: Column(
          children: [
            TextFormField(
              controller: meaningController,
              style: const TextStyle(
                // color: kOnBackgroundColor,
                fontSize: kSearchFontSize,
              ),
              validator: (va) {
                if (va!.isEmpty) {
                  return "meaning must not be empty".tr;
                }
                return null;
              },
              decoration: InputDecoration(
                labelText: 'Meaning'.tr,
                labelStyle: const TextStyle(
                    // color: kGreyColor,
                    ),
                hintStyle: const TextStyle(
                    // color: kGreyColor,
                    ),
                filled: true,
                // fillColor: kBackgroundColor,
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                  borderRadius: BorderRadius.all(
                    Radius.circular(kBorderRadiusS),
                  ),
                ),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                  borderRadius: BorderRadius.all(
                    Radius.circular(kBorderRadiusS),
                  ),
                ),
              ),
            ),
            const SizedBox(height: kSizeBoxS),
            TextFormField(
              controller: exampleController,
              style: const TextStyle(
                // color: kOnBackgroundColor,
                fontSize: kSearchFontSize,
              ),
              decoration: InputDecoration(
                labelText: 'Example'.tr,
                labelStyle: const TextStyle(
                    // color: kGreyColor,
                    ),
                hintStyle: const TextStyle(
                    // color: kGreyColor,
                    ),
                filled: true,
                // fillColor: kBackgroundColor,
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                  borderRadius: BorderRadius.all(
                    Radius.circular(kBorderRadiusS),
                  ),
                ),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                  borderRadius: BorderRadius.all(
                    Radius.circular(kBorderRadiusS),
                  ),
                ),
              ),
            ),
            const SizedBox(height: kSizeBoxS),
            TextFormField(
              controller: exampleTranslationController,
              style: const TextStyle(
                // color: kOnBackgroundColor,
                fontSize: kSearchFontSize,
              ),
              decoration: InputDecoration(
                labelText: 'Example Translation'.tr,
                labelStyle: const TextStyle(
                    // color: kGreyColor,
                    ),
                hintStyle: const TextStyle(
                    // color: kGreyColor,
                    ),
                filled: true,
                // fillColor: kBackgroundColor,
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                  borderRadius: BorderRadius.all(
                    Radius.circular(kBorderRadiusS),
                  ),
                ),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                  borderRadius: BorderRadius.all(
                    Radius.circular(kBorderRadiusS),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Get.defaultDialog(
              title: 'Delete Meaning'.tr,
              content: Text('Are you sure you want to delete this meaning?'.tr),
              actions: [
                TextButton(
                  onPressed: () {
                    FirebaseApi.deleteMeaning(meaning, expressionId);
                    Get.back();
                    Get.back();
                    Snack.success('Meaning deleted successfully'.tr);
                  },
                  child: Text(
                    'Delete'.tr,
                    // style: const TextStyle(color: kErrorColor),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: Text('Cancel'.tr),
                ),
              ],
            );
          },
          child: Text(
            'Delete'.tr,
            // style: const TextStyle(color: kErrorColor),
          ),
        ),
        TextButton(
          onPressed: () {
            Get.back();
          },
          child: Text('Cancel'.tr),
        ),
        TextButton(
          onPressed: () {
            if (!meaningFormKey.currentState!.validate()) {
              return;
            }
            meaningFormKey.currentState!.save();
            Meaning m = Meaning(
              id: meaning.id,
              addedOn: meaning.addedOn,
              updatedOn: DateTime.now(),
              meaning: meaningController.text,
              example: exampleController.text,
              exampleTranslation: exampleTranslationController.text,
              grammar: meaning.grammar,
              expressionId: meaning.expressionId != ''
                  ? meaning.expressionId
                  : expressionId,
              addedBy: meaning.addedBy,
              updatedBy: meaning.updatedBy,
              state: meaning.state,
            );

            FirebaseApi.updateMeaning(
              expressionId: expressionId,
              meaning: m,
            );
            Get.back();
            Snack.success('Meaning updated successfully'.tr);
            if (onEdit != null) {
              onEdit();
            }
          },
          child: Text('Update'.tr),
        ),
      ],
    );
  }

  clearBindings() {
    expression.value = null;
    meaning.value = null;
    meanings.clear();
  }

  @override
  void onReady() {
    super.onReady();
    DictionaryService.to.expression.listen((p0) {
      if (p0 != null) {
        expression.value = p0;
        meanings.bindStream(FirebaseApi.readMeanings(p0.id));
      } else {
        expression.value = null;
        meanings.clear();
      }
    });
  }
}
