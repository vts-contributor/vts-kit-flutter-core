import 'package:flutter/material.dart';

export 'external.dart';
export 'generated/core.dart';
export 'generated/core_en.dart' hide CoreLocalizationsEn;
export 'generated/core_vi.dart' hide CoreLocalizationsVi;

const List<Locale> SUPPORTED_LOCALES = [Locale('vi'), Locale('en')];

const Map<String, String> LANGUAGE_MAP = {
  'vi': 'Tiếng Việt',
  'en': 'English',
};
