import 'package:flutter/material.dart';

import '../../../core/configs/constants.dart';
import '../../../core/configs/sizes.dart';

class SimpleAppBarHeader extends StatelessWidget {
  const SimpleAppBarHeader({
    super.key,
    this.icon,
    this.title,
    this.titleFontSize,
    this.actions,
  });

  final IconData? icon;
  final String? title;
  final double? titleFontSize;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                icon ?? Icons.menu,
                color: Theme.of(context).colorScheme.onBackground,
              ),
            ),
            const SizedBox(width: kSizeBoxM),
            Text(
              title ?? kAppName,
              overflow: TextOverflow.ellipsis,
              softWrap: true,
              style: TextStyle(
                // color: kOnBackgroundColor,
                fontSize: titleFontSize ?? kTitleFontSize,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        if (actions != null) ...actions!,
      ],
    );
  }
}
