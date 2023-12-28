import 'package:flutter/material.dart';
import 'package:kitaabua/app/controllers/meanings_controller.dart';
import 'package:kitaabua/app/services/dictionary_service.dart';
import 'package:kitaabua/database/models/meaning.dart';

import '../../../core/configs/sizes.dart';

class MeaningCard extends StatelessWidget {
  const MeaningCard({
    super.key,
    required this.meaning,
    required this.expressionId,
  });

  final Meaning meaning;
  final String expressionId;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      onTap: () {
        // DictionaryService.to.openExpression(expression: expression);
      },
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: RichText(
              softWrap: true,
              text: TextSpan(
                text: meaning.meaning,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onBackground,
                  fontWeight: FontWeight.bold,
                  // fontSize: kHeadingFontSize,
                  height: 1.5,
                ),
                children: <TextSpan>[
                  const TextSpan(
                    text: " ( ",
                    style: TextStyle(
                      //   color: kOnBackgroundColor,
                      fontWeight: FontWeight.normal,
                      //  fontSize: kSubHeadingFontSize,
                      height: 1.5,
                    ),
                  ),
                  TextSpan(
                    text: meaning.grammar,
                    style: const TextStyle(
                      //   color: kOnBackgroundColor,
                      fontWeight: FontWeight.normal,
                      //  fontSize: kSubHeadingFontSize,
                      height: 1.5,
                    ),
                  ),
                  const TextSpan(
                    text: " ) ",
                    style: TextStyle(
                      //   color: kOnBackgroundColor,
                      fontWeight: FontWeight.normal,
                      // fontSize: kSubHeadingFontSize,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (DictionaryService.to.canManageDictionary())
            IconButton(
              padding: const EdgeInsets.all(0),
              iconSize: 20,
              onPressed: () {
                MeaningsController.to.editMeaningDialog(
                    expressionId: expressionId, meaning: meaning);
              },
              icon: const Icon(
                Icons.edit,
                // color: kOnBackgroundColor,
              ),
            ),
        ],
      ),
      contentPadding:
          const EdgeInsets.symmetric(horizontal: kPaddingS, vertical: 0),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              meaning.example!,
              style: TextStyle(
                color: Theme.of(context).colorScheme.secondary,
                  fontSize: kSummaryFontSize,
                fontStyle: FontStyle.italic,
                height: 1.5,
              ),
            ),
            Text(
              meaning.exampleTranslation!,
              style: TextStyle(
                color: Theme.of(context).colorScheme.error,
                  fontSize: kSummaryFontSize,
                fontStyle: FontStyle.italic,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
