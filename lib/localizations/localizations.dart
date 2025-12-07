import 'package:flutter/material.dart';
import 'package:flutter_core/models/language.dart';
import 'package:flutter_core/models/languages.dart';

export 'external.dart';
export 'generated/core.dart';
export 'generated/core_en.dart' hide CoreLocalizationsEn;
export 'generated/core_vi.dart' hide CoreLocalizationsVi;

const List<Locale> SUPPORTED_LOCALES = LanguageDefined.kLocaleSupported;

const Map<String, Language> LANGUAGE_MAP = LanguageDefined.kLanguageMap;
