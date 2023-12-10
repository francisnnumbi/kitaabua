import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kitaabua/app/ui/widgets/subtitle_block.dart';

import '../../../../core/configs/colors.dart';
import '../../../../core/configs/sizes.dart';
import '../../../../database/models/meaning.dart';
import '../../../services/dictionary_service.dart';
import '../../widgets/app_bar_header.dart';
import '../../widgets/meaning_card.dart';

class AddEditPage extends StatelessWidget {
  AddEditPage({super.key}) {
    wordEC.text = DictionaryService.to.expression.value?.word ?? "";
  }

  static const String route = "/expressions/add-edit";
  final _addEditFormKey = GlobalKey<FormState>();
  final TextEditingController wordEC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        DictionaryService.to.expression.value = null;
        return true;
      },
      child: Scaffold(
        backgroundColor: kBackgroundColor,
        body: Padding(
          padding: const EdgeInsets.fromLTRB(16, 40, 16, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              AppBarHeader(
                hasBackButton: true,
                title: DictionaryService.to.expression.value == null
                    ? "New"
                    : "Expression",
                titleFontSize: kSubTitleFontSize,
                icon: Icons.save,
                onPressed: () {
                  if (!_addEditFormKey.currentState!.validate()) {
                    return;
                  }
                  _addEditFormKey.currentState!.save();

                  DictionaryService.to.addExpression(word: wordEC.text);
                },
              ),
              const SizedBox(height: kSizeBoxL),
              Form(
                key: _addEditFormKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: wordEC,
                      validator: (va) {
                        if (va!.isEmpty) {
                          return "Title must not be empty".tr;
                        }
                        return null;
                      },
                      readOnly: !DictionaryService.to.canManageDictionary(),
                      style: const TextStyle(
                        color: kOnBackgroundColor,
                        fontSize: kSearchFontSize,
                      ),
                      maxLines: 2,
                      cursorColor: kOnBackgroundColor,
                      decoration: InputDecoration(
                        hintText: 'Enter expression',
                        hintStyle: const TextStyle(
                          color: kGreyColor,
                        ),
                        labelText: 'Expression',
                        labelStyle: const TextStyle(
                          color: kGreyColor,
                        ),
                        alignLabelWithHint: true,
                        filled: true,
                        fillColor: kDarkBackgroundColor,
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
                      autofocus: true,
                      textAlignVertical: TextAlignVertical.top,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: kSizeBoxL),
              const SubtitleBlock(
                title: "Meanings",
                titleFontSize: kSubTitleFontSize,
                icon: Icons.menu_book,
              ),
              Expanded(
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.only(top: kPaddingS),
                  itemCount: DictionaryService.to.expression.value == null
                      ? 0
                      : DictionaryService.to.expression.value!.meanings!.length,
                  itemBuilder: (context, index) {
                    Meaning meaning =
                        DictionaryService.to.expression.value!.meanings![index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: kPaddingS),
                      child: MeaningCard(
                        meaning: meaning,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: !DictionaryService.to.canManageDictionary()
            ? null
            : FloatingActionButton(
                mini: true,
                tooltip: "Add Meaning",
                backgroundColor: kDarkBackgroundColor,
                foregroundColor: kOnBackgroundColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(kBorderRadius),
                ),
                elevation: 10,
                onPressed: DictionaryService.to.expression.value == null
                    ? null
                    : () {
                        // DictionaryService.to.openExpression();
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
