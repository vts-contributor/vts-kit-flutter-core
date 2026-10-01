
import 'package:flutter/material.dart';
import 'package:flutter_core/models/language.dart';

abstract class LanguageDefined {

  static const kLanguageCodeEnglish = "en";
  static const kLanguageCodeVietnamese = "vi";
  static const kLanguageCodeKhmer = "km";
  static const kLanguageCodeMyanmar = "my";

  static const kLanguageEnglishUS = "English";
  static const kLanguageVietnamese = "Tiếng Việt";
  static const kLanguageKhmer = "ភាសាខ្មែរ";
  static const kLanguageMyanmar = "မြန်မာဘာသာ";

  static const kLanguageEnUS = Language(kLanguageCodeEnglish, kLanguageEnglishUS);
  static const kLanguageViVN = Language(kLanguageCodeVietnamese, kLanguageVietnamese);
  static const kLanguageKmKH = Language(kLanguageCodeKhmer, kLanguageKhmer);
  static const kLanguageMyMM = Language(kLanguageCodeMyanmar, kLanguageMyanmar);


  static const kLocaleSupported = [
    Locale(kLanguageCodeEnglish),
    Locale(kLanguageCodeVietnamese),
    Locale(kLanguageCodeKhmer),
    Locale(kLanguageCodeMyanmar),
  ];

  static const kLanguageList = [
    kLanguageEnUS,
    kLanguageViVN,
    kLanguageKmKH,
    kLanguageMyMM,
  ];

  static const kLanguageMap = {
    kLanguageCodeEnglish: kLanguageEnUS,
    kLanguageCodeVietnamese: kLanguageViVN,
    kLanguageCodeKhmer: kLanguageKmKH,
    kLanguageCodeMyanmar: kLanguageMyMM,
  };
}
