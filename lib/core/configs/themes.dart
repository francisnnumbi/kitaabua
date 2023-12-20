import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class _ThemeColors {}

class _lightColors extends _ThemeColors {
  static const Color primaryColor = Color(0xFFBBDEFB);
  static const Color accentColor = Color(0xFFB2EBF2);
  static const Color successColor = Color(0xFF247E1A);
  static const Color warningColor = Color(0xFF7E491A);
  static const Color errorColor = Color(0xFFB00020);
  static const Color surfaceColor = Color(0xFFFFFFFF);
  static const Color backgroundColor = Colors.grey;
  static const Color onPrimaryColor = Color(0xFFFFFFFF);
  static const Color onSecondaryColor = Color(0xFF000000);
  static const Color onBackgroundColor = Color(0xFFFFFFFF);
  static const Color onSurfaceColor = Color(0xFF000000);
  static const Color onErrorColor = Color(0xFFFFFFFF);
  static const Color onSuccessColor = Color(0xFFFFFFFF);
}

class _darkColors extends _ThemeColors {
  static const Color primaryColor = Color(0xFF1A237E);
  static const Color accentColor = Color(0xFF0097A7);
  static const Color successColor = Color(0xFF247E1A);
  static const Color warningColor = Color(0xFF7E491A);
  static const Color errorColor = Color(0xFFB00020);
  static const Color surfaceColor = Color(0xFFFFFFFF);
  static const Color backgroundColor = Colors.grey;
  static const Color onPrimaryColor = Color(0xFFFFFFFF);
  static const Color onSecondaryColor = Color(0xFF000000);
  static const Color onBackgroundColor = Color(0xFFFFFFFF);
  static const Color onSurfaceColor = Color(0xFF000000);
  static const Color onErrorColor = Color(0xFFFFFFFF);
  static const Color onSuccessColor = Color(0xFFFFFFFF);
}

class Themes {
  static const String LIGHT = 'light';
  static const String DARK = 'dark';
  static const String SYSTEM = 'system';

  static _ThemeColors colors(String themeMode) {
    switch (themeMode) {
      case Themes.LIGHT:
        return _lightColors();
      case Themes.DARK:
        return _darkColors();
      default:
        return _lightColors();
    }
  }

  ///@param {double} seed - A smallest value to be used for generating different font sizes. if not provided, default value is 8.
  ///
  static TextTheme customTextTheme(BuildContext context,
      {double? seed, Color? color}) {
    seed = seed ?? 8;
    return TextTheme(
      displayLarge: Theme.of(context).textTheme.displayLarge!.copyWith(
            fontSize: seed + 20,
            color: color,
          ),
      displayMedium: Theme.of(context).textTheme.displayMedium!.copyWith(
            fontSize: seed + 18,
            color: color,
          ),
      displaySmall: Theme.of(context).textTheme.displaySmall!.copyWith(
            fontSize: seed + 16,
            color: color,
          ),
      titleLarge: Theme.of(context).textTheme.titleLarge!.copyWith(
            fontSize: seed + 16,
            color: color,
          ),
      titleMedium: Theme.of(context).textTheme.titleMedium!.copyWith(
            fontSize: seed + 14,
            color: color,
          ),
      titleSmall: Theme.of(context).textTheme.titleSmall!.copyWith(
            fontSize: seed + 12,
            color: color,
          ),
      headlineLarge: Theme.of(context).textTheme.headlineLarge!.copyWith(
            fontSize: seed + 12,
            color: color,
          ),
      headlineMedium: Theme.of(context).textTheme.headlineMedium!.copyWith(
            fontSize: seed + 10,
            color: color,
          ),
      headlineSmall: Theme.of(context).textTheme.headlineSmall!.copyWith(
            fontSize: seed + 8,
            color: color,
          ),
      bodyLarge: Theme.of(context).textTheme.bodyLarge!.copyWith(
            fontSize: seed + 8,
            color: color,
          ),
      bodyMedium: Theme.of(context).textTheme.bodyMedium!.copyWith(
            fontSize: seed + 6,
            color: color,
          ),
      bodySmall: Theme.of(context).textTheme.bodySmall!.copyWith(
            fontSize: seed + 4,
            color: color,
          ),
      labelLarge: Theme.of(context).textTheme.labelLarge!.copyWith(
            fontSize: seed + 4,
            color: color,
          ),
      labelMedium: Theme.of(context).textTheme.labelMedium!.copyWith(
            fontSize: seed + 2,
            color: color,
          ),
      labelSmall: Theme.of(context).textTheme.labelSmall!.copyWith(
            fontSize: seed,
            color: color,
          ),
    );
  }

  static ThemeData light(
    BuildContext context,
  ) {
    return ThemeData.light().copyWith(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
      textTheme: GoogleFonts.tekoTextTheme(
        Themes.customTextTheme(context, seed: 8, color: Colors.black),
      ),
      listTileTheme: Theme.of(context).listTileTheme.copyWith(
            tileColor: Colors.grey.shade300,
            titleTextStyle: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
      bottomNavigationBarTheme:
          Theme.of(context).bottomNavigationBarTheme.copyWith(
                backgroundColor: Colors.white,
                selectedItemColor: Colors.black,
                unselectedItemColor: Colors.grey,
              ),
    );
  }

  static ThemeData dark(
    BuildContext context,
  ) {
    return ThemeData.dark().copyWith(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
      textTheme: GoogleFonts.tekoTextTheme(
        Themes.customTextTheme(context, seed: 8, color: Colors.white),
      ),
      listTileTheme: Theme.of(context).listTileTheme.copyWith(
            iconColor: Colors.grey,
            tileColor: Colors.grey.shade800,
            titleTextStyle: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            subtitleTextStyle: TextStyle(
              color: Colors.grey.shade600,
            ),
          ),
      bottomNavigationBarTheme:
          Theme.of(context).bottomNavigationBarTheme.copyWith(
                backgroundColor: Colors.grey.shade600,
                selectedItemColor: Colors.white,
                unselectedItemColor: Colors.grey.shade700,
              ),
    );
  }
}
