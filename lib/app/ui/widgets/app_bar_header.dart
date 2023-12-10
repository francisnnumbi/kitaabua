import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/configs/colors.dart';
import '../../../core/configs/constants.dart';
import '../../../core/configs/sizes.dart';
import '../../services/auth_service.dart';

class AppBarHeader extends StatelessWidget {
  const AppBarHeader({
    super.key,
    this.hasBackButton = false,
    this.title,
    this.titleFontSize,
    this.icon,
    this.onPressed,
  });

  final bool hasBackButton;
  final String? title;
  final double? titleFontSize;
  final IconData? icon;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
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
                    color: kDarkBackgroundColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.arrow_back,
                    color: kOnBackgroundColor,
                  ),
                ),
              ),
            if (hasBackButton) const SizedBox(width: kSizeBoxS),
            Text(
              title ?? kAppName,
              overflow: TextOverflow.ellipsis,
              softWrap: true,
              style: TextStyle(
                color: kOnBackgroundColor,
                fontSize: titleFontSize ?? kTitleFontSize,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        if (onPressed != null && AuthService.to.isLoggedIn.value)
          IconButton(
            onPressed: onPressed,
            padding: const EdgeInsets.all(0),
            icon: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: kDarkBackgroundColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                icon ?? Icons.swap_horiz,
                color: kOnBackgroundColor,
              ),
            ),
          ),
      ],
    );
  }
}
