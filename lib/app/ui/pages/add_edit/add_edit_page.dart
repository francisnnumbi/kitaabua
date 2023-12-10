import 'package:flutter/material.dart';

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

                //DictionaryService.to.saveExpression();
              },
            ),
            const SizedBox(height: kSizeBoxM),
            Expanded(
              child: Form(
                key: _addEditFormKey,
                child: Column(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
