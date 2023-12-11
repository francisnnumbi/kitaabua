import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kitaabua/database/api/firebase_api.dart';

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
      title: 'Add Meaning',
      content: Form(
        key: meaningFormKey,
        child: Column(
          children: [
            TextFormField(
              controller: meaningController,
              validator: (va) {
                if (va!.isEmpty) {
                  return "meaning must not be empty".tr;
                }
                return null;
              },
              decoration: const InputDecoration(
                labelText: 'Meaning',
              ),
            ),
            TextFormField(
              controller: exampleController,
              decoration: const InputDecoration(
                labelText: 'Example',
              ),
            ),
            TextFormField(
              controller: exampleTranslationController,
              decoration: const InputDecoration(
                labelText: 'Example Translation',
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
          child: const Text('Cancel'),
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
            Get.snackbar('Success', 'Meaning added successfully');
            if (onAdd != null) {
              onAdd();
            }
          },
          child: const Text('Add'),
        ),
      ],
    );
  }
}
