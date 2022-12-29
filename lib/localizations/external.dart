import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_core/bases/storage.dart';
import 'package:flutter_core/localizations/localizations.dart';

class ExternalLocalizations {
  final Locale locale;

  ExternalLocalizations(this.locale);

  static ExternalLocalizations? of(BuildContext context) {
    return Localizations.of<ExternalLocalizations>(
        context, ExternalLocalizations);
  }

  static const LocalizationsDelegate<ExternalLocalizations> delegate =
      _ExternalLocalizationsDelegate();

  Map<String, String> _localizedStrings = {};

  Future<bool> load() async {
    Map<String, dynamic>? jsonMap =
        await Storage.readJsonFile('${locale.languageCode}.json');
    if (jsonMap != null) {
      _localizedStrings =
          jsonMap.map((key, value) => MapEntry(key, value.toString()));
    } else {
      _localizedStrings.clear();
    }
    return true;
  }

  String getString(String key) {
    return _localizedStrings[key] ?? '';
  }
}

class _ExternalLocalizationsDelegate
    extends LocalizationsDelegate<ExternalLocalizations> {
  const _ExternalLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => SUPPORTED_LOCALES
      .any((supported) => supported.languageCode == locale.languageCode);

  @override
  Future<ExternalLocalizations> load(Locale locale) async {
    final localizations = new ExternalLocalizations(locale);
    await localizations.load();
    return localizations;
  }

  @override
  bool shouldReload(_ExternalLocalizationsDelegate old) => true;
}
