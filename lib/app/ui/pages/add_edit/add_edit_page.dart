import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kitaabua/app/controllers/meanings_controller.dart';
import 'package:kitaabua/app/controllers/members_controller.dart';
import 'package:kitaabua/app/ui/widgets/subtitle_block.dart';
import 'package:kitaabua/core/configs/utils.dart';

import '../../../../core/configs/sizes.dart';
import '../../../../database/models/meaning.dart';
import '../../../services/dictionary_service.dart';
import '../../widgets/app_bar_header.dart';
import '../../widgets/meaning_card.dart';

class AddEditPage extends StatelessWidget {
  AddEditPage({super.key}) {
    // wordEC.text = DictionaryService.to.expression.value?.word ?? "";
  }

  static const String route = "/expressions/add-edit";
  final _addEditFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (value) async {
        Utils.hideKeyboard(context);
        DictionaryService.to.expression.value = null;
        DictionaryService.to.wordEC.text = "";
      },
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                AppBarHeader(
                  hasBackButton: true,
                  title: DictionaryService.to.expression.value == null
                      ? "New".tr
                      : "Expression".tr,
                  titleFontSize: kSubTitleFontSize,
                  icon: Icons.save,
                  onPressed: () {
                    if (!_addEditFormKey.currentState!.validate()) {
                      return;
                    }
                    _addEditFormKey.currentState!.save();

                    DictionaryService.to
                        .addExpression(word: DictionaryService.to.wordEC.text);
                  },
                ),
                const SizedBox(height: kSizeBoxL),
                Form(
                  key: _addEditFormKey,
                  child: Column(
                    children: [
                      Obx(() {
                        return TextFormField(
                          controller: DictionaryService.to.wordEC,
                          onChanged: (value) {
                            DictionaryService.to.fetchSimilarExpressions(value);
                          },
                          validator: (va) {
                            if (va!.isEmpty) {
                              return "Title must not be empty".tr;
                            } else if (DictionaryService.to.wordExists(va)) {
                              return "This word already exists".tr;
                            }
                            return null;
                          },
                          readOnly: !DictionaryService.to.canManageDictionary(),

                          maxLines: 2,
                          //   cursorColor: kOnBackgroundColor,
                          decoration: InputDecoration(
                            hintText: 'Enter expression'.tr,
                            labelText: 'Expression'.tr,
                            alignLabelWithHint: true,
                            filled: true,
                            // fillColor: kDarkBackgroundColor,
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
                          //autofocus: true,
                          textAlignVertical: TextAlignVertical.top,
                        );
                      }),
                      if (MembersController.to.isLoggedIn)
                        const SizedBox(height: kSizeBoxS),
                      if (MembersController.to.isLoggedIn)
                        SubtitleBlock(
                          title: "Similar Words".tr,
                          titleFontSize: kSummaryFontSize,
                        ),
                      const SizedBox(height: kSizeBoxS),
                      Obx(() {
                        return Align(
                          alignment: Alignment.centerLeft,
                          child: Wrap(
                            children: DictionaryService.to
                                .similarExpressions()
                                .map(
                                  (e) => Padding(
                                    padding: const EdgeInsets.all(
                                      2,
                                    ),
                                    child: InkWell(
                                      onTap: () {
                                        DictionaryService.to.openExpression(
                                            expression: e, off: true);
                                      },
                                      child: Badge(
                                        //     backgroundColor: kSurfaceColor,
                                        //isLabelVisible: false,
                                        label: Text(
                                          e.word,
                                          style: const TextStyle(
                                              //      color: kOnSurfaceColor,
                                              ),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                                .toList(
                                  growable: false,
                                ),
                          ),
                        );
                      }),
                    ],
                  ),
                ),
                const SizedBox(height: kSizeBoxL),
                SubtitleBlock(
                  title: "Meanings".tr,
                  titleFontSize: kSubHeadingFontSize,
                  icon: Icons.menu_book,
                ),
                Expanded(
                  child: Obx(() {
                    return ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.only(top: kPaddingS),
                      itemCount: MeaningsController.to.meanings.length,
                      itemBuilder: (context, index) {
                        Meaning meaning = MeaningsController.to.meanings[index];

                        return Padding(
                          padding: const EdgeInsets.only(bottom: kPaddingS),
                          child: MeaningCard(
                            expressionId:
                                MeaningsController.to.expression.value!.id,
                            meaning: meaning,
                          ),
                        );
                      },
                    );
                  }),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: !DictionaryService.to.canManageDictionary()
            ? null
            : FloatingActionButton(
                mini: true,
                tooltip: "Add Meaning".tr,
                //  backgroundColor: kDarkBackgroundColor,
                //  foregroundColor: kOnBackgroundColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(kBorderRadius),
                ),
                elevation: 10,
                onPressed: DictionaryService.to.expression.value == null
                    ? null
                    : () {
                        MeaningsController.to.addMeaningDialog(
                          expressionId:
                              DictionaryService.to.expression.value!.id,
                          onAdd: () async {
                            DictionaryService.to.refreshExpressions();
                            await DictionaryService.to.expression.value!
                                .reloadMeanings();
                          },
                        );
                      },
                child: const Icon(
                  Icons.add,
                  size: kSizeBoxXL,
                ),
              ),
      ),
    );
  }
}
