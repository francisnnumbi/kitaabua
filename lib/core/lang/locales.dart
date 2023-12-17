import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../main.dart';
import 'en.dart';
import 'fr.dart';

class Locales extends Translations {
  @override
  // TODO: implement keys
  Map<String, Map<String, String>> get keys => {
        'en_US': en,
        'fr_FR': fr,
      };

  Map<String, String> get labels => {
        'en_US': 'English',
        'fr_FR': 'Français',
      };

  static Locale getStoredLocale() {
    final lang = InnerStorage.read('lang') ??
        {
          'name': 'Français',
          'code': 'fr_FR',
        };
    final langCode = lang['code'].split("_");
    return Locale(langCode[0], langCode[1]);
  }

  static Map<String, String> getLabelOf(String code) {
    return {
      'name': Locales().labels[code]!,
      'code': code,
    };
  }

/*  static Map<String, String> getLabelFromStored() {
    final lang = InnerStorage.read('lang') ??
        {
          'name': 'Français',
          'code': 'fr_FR',
        };
    return lang;
  }*/

/*  static Map<String, String> getLabel2FromStored() {
    final lang = InnerStorage.read('lang') ??
        {
          'name': 'Français',
          'code': 'fr_FR',
        };
    return {
      lang['code']: Locales().labels[lang['code']]!,
    };
  }*/
}
