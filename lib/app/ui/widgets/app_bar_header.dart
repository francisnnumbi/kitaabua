import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/configs/constants.dart';
import '../../../core/configs/sizes.dart';
import '../../services/dictionary_service.dart';

class AppBarHeader extends StatelessWidget {
  const AppBarHeader({
    super.key,
    this.hasBackButton = false,
    this.title,
    this.titleFontSize,
    this.icon,
    this.onPressed,
    this.actions,
  });

  final bool hasBackButton;
  final String? title;
  final double? titleFontSize;
  final IconData? icon;
  final VoidCallback? onPressed;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              if (hasBackButton)
                IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  padding: const EdgeInsets.all(0),
                  icon: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      //  color: kDarkBackgroundColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      Icons.arrow_back,
                      //    color: kOnBackgroundColor,
                    ),
                  ),
                ),
              if (hasBackButton) const SizedBox(width: kSizeBoxS),
              Text(
                title ?? kAppName,
                overflow: TextOverflow.ellipsis,
                softWrap: true,
                style: TextStyle(
                  // color: kOnBackgroundColor,
                  fontSize: titleFontSize ??
                      Theme.of(context).textTheme.titleLarge!.fontSize,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (onPressed != null && DictionaryService.to.canManageDictionary())
              IconButton(
                onPressed: onPressed,
                padding: const EdgeInsets.all(0),
                icon: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    //color: kDarkBackgroundColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    icon ?? Icons.swap_horiz,
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
                ),
              ),
            if (actions != null) ...actions!,
          ],
        ),
      ],
    );
  }
}
