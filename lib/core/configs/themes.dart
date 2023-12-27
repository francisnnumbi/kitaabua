import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../main.dart';

class _Colors {
  static const lightColors = {
    'primary': Color(0xFF6200EE),
    'primaryVariant': Color(0xFF3700B3),
    'secondary': Color(0xFF03DAC6),
    'secondaryVariant': Color(0xFF018786),
    'surface': Color(0xFFFFFFFF),
    'background': Color(0xFFEDEDED),
    'error': Color(0xFFB00020),
    'onPrimary': Color(0xFFFFFFFF),
    'onSecondary': Color(0xFF000000),
    'onSurface': Color(0xFF000000),
    'onBackground': Color(0xFF000000),
    'onError': Color(0xFFFFFFFF),
    'tertiary': Color(0xFFEDEDED),
  };
  static const darkColors = {
    'primary': Color(0xFF6200EE),
    'primaryVariant': Color(0xFF3700B3),
    'secondary': Color(0xFF03DAC6),
    'secondaryVariant': Color(0xFF018786),
    'surface': Color(0xFF121212),
    'background': Color(0xFF121212),
    'error': Color(0xFFCF6679),
    'onPrimary': Color(0xFFFFFFFF),
    'onSecondary': Color(0xFF000000),
    'onSurface': Color(0xFFFFFFFF),
    'onBackground': Color(0xFFFFFFFF),
    'onError': Color(0xFF000000),
    'tertiary': Color(0xFF121212),
  };
}

class _ColorScheme extends ColorScheme {
  const _ColorScheme({
    required this.primary,
    required this.primaryVariant,
    required this.secondary,
    required this.secondaryVariant,
    required this.surface,
    required this.background,
    required this.error,
    required this.onPrimary,
    required this.onSecondary,
    required this.onSurface,
    required this.onBackground,
    required this.onError,
    required this.brightness,
    this.tertiary = Colors.grey,
  }) : super(
          brightness: brightness,
          primary: primary,
          onPrimary: onPrimary,
          secondary: secondary,
          surface: surface,
          background: background,
          error: error,
          onSecondary: onSecondary,
          onSurface: onSurface,
          onBackground: onBackground,
          onError: onError,
          tertiary: tertiary,
        );

  final Color primary;
  final Color primaryVariant;
  final Color secondary;
  final Color secondaryVariant;
  final Color tertiary;
  final Color surface;
  final Color background;
  final Color error;
  final Color onPrimary;
  final Color onSecondary;
  final Color onSurface;
  final Color onBackground;
  final Color onError;
  final Brightness brightness;

  static _ColorScheme fromSeed({
    required Color seedColor,
    bool dark = false,
  }) {
    return _ColorScheme(
      primary: seedColor,
      primaryVariant: seedColor,
      secondary: seedColor,
      secondaryVariant: seedColor,
      surface: seedColor,
      background: seedColor,
      error: seedColor,
      onPrimary: seedColor,
      onSecondary: seedColor,
      onSurface: seedColor,
      onBackground: seedColor,
      onError: seedColor,
      tertiary: seedColor,
      brightness: dark ? Brightness.light : Brightness.dark,
    );
  }

  static _ColorScheme fromColors(
    Map<String, Color> colors, {
    required Brightness brightness,
  }
      /*{
    required Color primary,
    required Color primaryVariant,
    required Color secondary,
    required Color secondaryVariant,
    required Color tertiary,
    required Color surface,
    required Color background,
    required Color error,
    required Color onPrimary,
    required Color onSecondary,
    required Color onSurface,
    required Color onBackground,
    required Color onError,
    required Brightness brightness,
  }*/
      ) {
    return _ColorScheme(
      primary: colors['primary']!,
      primaryVariant: colors['primaryVariant']!,
      secondary: colors['secondary']!,
      secondaryVariant: colors['secondaryVariant']!,
      tertiary: colors['tertiary']!,
      surface: colors['surface']!,
      background: colors['background']!,
      error: colors['error']!,
      onPrimary: colors['onPrimary']!,
      onSecondary: colors['onSecondary']!,
      onSurface: colors['onSurface']!,
      onBackground: colors['onBackground']!,
      onError: colors['onError']!,
      brightness: brightness,
    );
  }
}

class Themes {
  static const String LIGHT = 'light';
  static const String DARK = 'dark';
  static const String SYSTEM = 'system';

  static get isDark => {
        Themes.LIGHT: false,
        Themes.DARK: true,
        Themes.SYSTEM: Get.isPlatformDarkMode,
      }[InnerStorage.read('themeMode') ?? Themes.LIGHT]!;

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
      colorScheme: _ColorScheme.fromColors(_Colors.lightColors,
          brightness: Brightness.dark),
      textTheme: GoogleFonts.tekoTextTheme(
        Themes.customTextTheme(context, seed: 8, color: Colors.black),
      ),
      listTileTheme: Theme.of(context).listTileTheme.copyWith(
            tileColor: Colors.grey.shade100,
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
      colorScheme: _ColorScheme.fromColors(_Colors.darkColors,
          brightness: Brightness.light),
      textTheme: GoogleFonts.tekoTextTheme(
        Themes.customTextTheme(context, seed: 8, color: Colors.white),
      ),
      listTileTheme: Theme.of(context).listTileTheme.copyWith(
            iconColor: Colors.grey,
            tileColor: Colors.grey.shade900,
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
