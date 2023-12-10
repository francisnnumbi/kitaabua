import 'package:flutter/material.dart';
import 'package:kitaabua/core/configs/colors.dart';
import 'package:kitaabua/core/configs/sizes.dart';

class WordSearchView extends StatelessWidget {
  const WordSearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: const TextStyle(
        color: kOnBackgroundColor,
        fontSize: kSearchFontSize,
      ),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(
          vertical: kPaddingM,
        ),
        hintText: 'Search word...',
        hintStyle: const TextStyle(
          color: kGreyColor,
        ),
        prefixIcon: const Icon(
          Icons.search,
          color: kGreyColor,
        ),
        filled: true,
        fillColor: kDarkBackgroundColor,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(kBorderRadius),
          borderSide: const BorderSide(color: Colors.transparent),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(kBorderRadius),
          borderSide: const BorderSide(color: Colors.transparent),
        ),
      ),
    );
  }
}
