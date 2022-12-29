import 'package:flutter/material.dart';
import 'package:flutter_core/bases/exceptions.dart';
import 'package:flutter_core/models/models.dart';
import 'package:rxdart/subjects.dart';
import 'package:flutter_core/extensions/extensions.dart';
import 'dart:ui';

class AppSetting {
  static final _languageSubject = PublishSubject<Locale?>();

  //language on UI
  static Language? _usingLanguage;

  //language of device
  static Language? deviceLanguage;

  //choose manual language or use device language
  static bool _chooseManualLanguage = false;

  //stream update UI language
  static Stream<Locale?> get languageStream => _languageSubject.stream;

  static Language? get usingLanguage => _usingLanguage;

  static bool get chooseManualLanguage => _chooseManualLanguage;

  static void setLanguage(Language language) {
    if (language.code == usingLanguage?.code) {
      return;
    }
    Locale? locale = Locale(language.code).supportedOrNull();
    if (locale != null) {
      _chooseManualLanguage = true;
      _languageSubject.add(locale);
      _usingLanguage = language;
    } else {
      throw UnsupportedLanguageException(
          'Language ${language.name} is not supported', language);
    }
  }

  static void resetOSLanguage() {
    _chooseManualLanguage = false;
    _languageSubject.add(null);
    _usingLanguage = deviceLanguage;
  }

  static void reloadCurrentLanguage() {
    final currentLanguage = usingLanguage;
    final locale = currentLanguage != null
        ? Locale(currentLanguage.code).supportedOrNull()
        : null;
    _languageSubject.add(locale);
  }
}
