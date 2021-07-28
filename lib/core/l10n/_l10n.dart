import 'package:flutter/material.dart';

import 'en_us.dart';
import 'ru_ru.dart';

abstract class AppTranslation {
  static Map<String, String> languages = const {
    'en_US': 'English',
    'ru_RU': 'Русский',
  };

  static Map<String, Map<String, String>> translations = {
    'en_US': enUS,
    'ru_RU': ruRU,
  };

  static String locale = 'en_US';
  static Map<String, Locale> locales = const {
    'en_US': Locale('en', 'US'),
    'ru_RU': Locale('ru', 'RU'),
  };
}
