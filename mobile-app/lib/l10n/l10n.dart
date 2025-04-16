import 'package:flutter/material.dart';

class L10n {
  static final List<Locale> all = <Locale>[
    const Locale('en'),
    const Locale('ar'),
  ];

  static String getFlag(String code) {
    switch (code) {
      case 'ar':
        return 'ar';

      case 'en':
      default:
        return '🇺🇸';
    }
  }
}
