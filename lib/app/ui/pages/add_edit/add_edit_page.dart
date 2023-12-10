import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/configs/colors.dart';
import '../../../../core/configs/sizes.dart';
import '../../../services/dictionary_service.dart';
import '../../widgets/app_bar_header.dart';

class AddEditPage extends StatelessWidget {
  AddEditPage({super.key});

  static String route = "/expressions/add-edit";
  final _addEditFormKey = GlobalKey<FormState>();
  final TextEditingController wordEC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 40, 16, 0),
        child: Column(
          children: [
            AppBarHeader(
              title: DictionaryService.to.expression.value == null
                  ? "Add Expression"
                  : "Edit Expression",
              icon: Icons.save,
              onPressed: () {
                if (!_addEditFormKey.currentState!.validate()) {
                  return;
                }
                _addEditFormKey.currentState!.save();

                DictionaryService.to.addExpression(word: wordEC.text);
              },
            ),
            const SizedBox(height: kSizeBoxM),
            Expanded(
              child: Form(
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
                      style: const TextStyle(
                        color: kOnBackgroundColor,
                        fontSize: kSearchFontSize,
                      ),
                      maxLines: 2,
                      cursorColor: kOnBackgroundColor,
                      decoration: InputDecoration(
                        hintText: 'Enter title',
                        hintStyle: const TextStyle(
                          color: kGreyColor,
                        ),
                        labelText: 'Title',
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
            ),
          ],
        ),
      ),
    );
  }
}
