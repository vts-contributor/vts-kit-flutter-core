import 'package:flutter/cupertino.dart';
import 'package:flutter_core/localizations/localizations.dart';

class Language {
  final String code;
  final String name;

  Language(this.code, this.name);

  factory Language.fromLocale(Locale locale) {
    final code = locale.languageCode;
    final name = LANGUAGE_MAP[code] ?? '';
    return Language(code, name);
  }
}
