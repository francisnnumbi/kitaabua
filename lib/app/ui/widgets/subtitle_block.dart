import 'package:flutter/material.dart';

import '../../../core/configs/constants.dart';
import '../../../core/configs/sizes.dart';

class SubtitleBlock extends StatelessWidget {
  const SubtitleBlock({
    super.key,
    this.title,
    this.titleFontSize,
    this.icon,
  });

  final String? title;
  final double? titleFontSize;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (icon != null)
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              // color: kDarkBackgroundColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              icon,
              color: Theme.of(context).colorScheme.background,
            ),
          ),
        if (icon != null) const SizedBox(width: kSizeBoxS),
        Text(
          title ?? kAppName,
          style: TextStyle(
            color: Theme.of(context).colorScheme.background,
            fontSize: titleFontSize ??
                Theme.of(context).textTheme.titleMedium!.fontSize,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(width: kSizeBoxS),
        Expanded(
          child: Container(
            height: 2,
            color: Theme.of(context).colorScheme.background,
          ),
        ),
      ],
    );
  }
}
