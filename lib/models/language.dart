import 'package:flutter/cupertino.dart';
import 'package:flutter_core/localizations/localizations.dart';
import 'package:flutter_core/models/languages.dart';

class Language {
  final String code;
  final String name;

  const Language(this.code, this.name);

  factory Language.fromLocale(Locale locale) {
    final code = locale.languageCode;
    return Language.fromCode(code);
  }

  factory Language.fromCode(String? code) {
    if (code == null) {
      return LanguageDefined.kLanguageEnUS;
    }
    final name = LANGUAGE_MAP[code]?.name ?? '';
    return Language(code, name);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Language &&
          runtimeType == other.runtimeType &&
          code == other.code &&
          name == other.name;

  @override
  int get hashCode => code.hashCode ^ name.hashCode;
}
