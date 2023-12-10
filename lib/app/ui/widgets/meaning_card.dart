import 'package:flutter/material.dart';
import 'package:kitaabua/database/models/meaning.dart';

import '../../../core/configs/colors.dart';
import '../../../core/configs/sizes.dart';

class MeaningCard extends StatelessWidget {
  const MeaningCard({
    super.key,
    required this.meaning,
  });

  final Meaning meaning;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.all(0),
      color: kDarkBackgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(kBorderRadiusS),
      ),
      child: ListTile(
        onTap: () {
          // DictionaryService.to.openExpression(expression: expression);
        },
        title: RichText(
          text: TextSpan(
            text: meaning.meaning,
            style: const TextStyle(
              color: kOnBackgroundColor,
              fontWeight: FontWeight.bold,
              fontSize: kHeadingFontSize,
              height: 1.5,
            ),
            children: <TextSpan>[
              const TextSpan(
                text: " ( ",
                style: TextStyle(
                  color: kOnBackgroundColor,
                  fontWeight: FontWeight.normal,
                  fontSize: kSubHeadingFontSize,
                  height: 1.5,
                ),
              ),
              TextSpan(
                text: meaning.grammar,
                style: const TextStyle(
                  color: kOnBackgroundColor,
                  fontWeight: FontWeight.normal,
                  fontSize: kSubHeadingFontSize,
                  height: 1.5,
                ),
              ),
              const TextSpan(
                text: " ) ",
                style: TextStyle(
                  color: kOnBackgroundColor,
                  fontWeight: FontWeight.normal,
                  fontSize: kSubHeadingFontSize,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: kPaddingS),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text(
            meaning.example,
            style: const TextStyle(
              color: kGreyColor,
              fontSize: kFooterFontSize,
              fontStyle: FontStyle.italic,
              height: 1.5,
            ),
          ),
        ),
        trailing: IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.edit,
            color: kOnBackgroundColor,
          ),
        ),
      ),
    );
  }
}
