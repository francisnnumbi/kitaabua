import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Themes {
  static const String LIGHT = 'light';
  static const String DARK = 'dark';
  static const String SYSTEM = 'system';

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
      buttonTheme: Theme.of(context).buttonTheme.copyWith(
            buttonColor: Colors.grey.shade300,
            textTheme: ButtonTextTheme.primary,
          ),
      floatingActionButtonTheme: Theme.of(context)
          .floatingActionButtonTheme
          .copyWith(backgroundColor: Colors.grey.shade300),
      bottomNavigationBarTheme:
          Theme.of(context).bottomNavigationBarTheme.copyWith(
                backgroundColor: Colors.grey.shade300,
                selectedItemColor: Colors.black,
                unselectedItemColor: Colors.black38,
                type: BottomNavigationBarType.fixed,
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
      floatingActionButtonTheme:
          Theme.of(context).floatingActionButtonTheme.copyWith(
                backgroundColor: Colors.grey.shade800,
                foregroundColor: Colors.white,
              ),
      bottomNavigationBarTheme:
          Theme.of(context).bottomNavigationBarTheme.copyWith(
                backgroundColor: Colors.grey.shade800,
                selectedItemColor: Colors.white,
                unselectedItemColor: Colors.grey.shade700,
                type: BottomNavigationBarType.fixed,
              ),
    );
  }
}
