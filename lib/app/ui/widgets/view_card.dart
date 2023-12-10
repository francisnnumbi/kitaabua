import 'package:flutter/material.dart';
import 'package:kitaabua/database/models/expression.dart';

import '../../../core/configs/colors.dart';
import '../../../core/configs/sizes.dart';

class ViewCard extends StatelessWidget {
  const ViewCard({
    super.key,
    required this.expression,
  });

  final Expression expression;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(kBorderRadiusS),
      ),
      child: ListTile(
        title: RichText(
          text: TextSpan(
            text: expression.word,
            style: const TextStyle(
              color: kOnSurfaceColor,
              fontWeight: FontWeight.bold,
              fontSize: kHeadingFontSize,
              height: 1.5,
            ),
            children: <TextSpan>[
              const TextSpan(
                text: " - ",
                style: TextStyle(
                  color: kOnSurfaceColor,
                  fontWeight: FontWeight.normal,
                  fontSize: kSubHeadingFontSize,
                  height: 1.5,
                ),
              ),
              TextSpan(
                text: expression.addedBy,
                style: const TextStyle(
                  color: kOnSurfaceColor,
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
            'Edited : ${expression.addedOn}',
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
          icon: const Icon(Icons.bookmark_add),
        ),
      ),
    );
  }
}
