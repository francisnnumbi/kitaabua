import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Themes {
  static const String LIGHT = 'light';
  static const String DARK = 'dark';
  static const String SYSTEM = 'system';

  ///@param {double} seed - A smallest value to be used for generating different font sizes. if not provided, default value is 8.
  ///
  static TextTheme customTextTheme(BuildContext context, {double? seed}) {
    seed = seed ?? 8;
    return TextTheme(
      displayLarge: Theme.of(context).textTheme.displayLarge!.copyWith(
            fontSize: seed + 20,
          ),
      displayMedium: Theme.of(context).textTheme.displayMedium!.copyWith(
            fontSize: seed + 18,
          ),
      displaySmall: Theme.of(context).textTheme.displaySmall!.copyWith(
            fontSize: seed + 16,
          ),
      titleLarge: Theme.of(context).textTheme.titleLarge!.copyWith(
            fontSize: seed + 16,
          ),
      titleMedium: Theme.of(context).textTheme.titleMedium!.copyWith(
            fontSize: seed + 14,
          ),
      titleSmall: Theme.of(context).textTheme.titleSmall!.copyWith(
            fontSize: seed + 12,
          ),
      headlineLarge: Theme.of(context).textTheme.headlineLarge!.copyWith(
            fontSize: seed + 12,
          ),
      headlineMedium: Theme.of(context).textTheme.headlineMedium!.copyWith(
            fontSize: seed + 10,
          ),
      headlineSmall: Theme.of(context).textTheme.headlineSmall!.copyWith(
            fontSize: seed + 8,
          ),
      bodyLarge: Theme.of(context).textTheme.bodyLarge!.copyWith(
            fontSize: seed + 8,
          ),
      bodyMedium: Theme.of(context).textTheme.bodyMedium!.copyWith(
            fontSize: seed + 6,
          ),
      bodySmall: Theme.of(context).textTheme.bodySmall!.copyWith(
            fontSize: seed + 4,
          ),
      labelLarge: Theme.of(context).textTheme.labelLarge!.copyWith(
            fontSize: seed + 4,
          ),
      labelMedium: Theme.of(context).textTheme.labelMedium!.copyWith(
            fontSize: seed + 2,
          ),
      labelSmall: Theme.of(context).textTheme.labelSmall!.copyWith(
            fontSize: seed,
          ),
    );
  }

  static ThemeData light(
    BuildContext context,
  ) {
    return ThemeData.light().copyWith(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
      textTheme: GoogleFonts.tekoTextTheme(
        Themes.customTextTheme(context, seed: 8),
      ),
    );
  }

  static ThemeData dark(
    BuildContext context,
  ) {
    return ThemeData.dark().copyWith(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
      textTheme: GoogleFonts.tekoTextTheme(
        Themes.customTextTheme(context, seed: 8),
      ),
    );
  }
}
