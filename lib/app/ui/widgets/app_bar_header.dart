import 'package:flutter/material.dart';

import '../../../core/configs/colors.dart';
import '../../../core/configs/constants.dart';
import '../../../core/configs/sizes.dart';

class AppBarHeader extends StatelessWidget {
  const AppBarHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          kAppName,
          style: TextStyle(
            color: kOnBackgroundColor,
            fontSize: kTitleFontSize,
            fontWeight: FontWeight.bold,
          ),
        ),
        IconButton(
          onPressed: () {},
          padding: const EdgeInsets.all(0),
          icon: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: kDarkBackgroundColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.swap_horiz,
              color: kOnBackgroundColor,
            ),
          ),
        ),
      ],
    );
  }
}
