import 'package:flutter/material.dart';
import 'package:flutter_core/localizations/localizations.dart';

extension Localex on Locale {
  Locale? supportedOrNull() {
    for (Locale locale in SUPPORTED_LOCALES) {
      if (this.languageCode == locale.languageCode) {
        return this;
      }
    }
    return null;
  }
}
