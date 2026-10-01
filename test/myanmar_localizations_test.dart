import 'package:flutter/material.dart';
import 'package:flutter_core/extensions/locales.dart';
import 'package:flutter_core/localizations/localizations.dart';
import 'package:flutter_core/models/language.dart';
import 'package:flutter_core/models/languages.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Myanmar is registered and recognized for regional locales', () {
    const locale = Locale('my', 'MM');

    expect(SUPPORTED_LOCALES, contains(const Locale('my')));
    expect(CoreLocalizations.supportedLocales, contains(const Locale('my')));
    expect(LanguageDefined.kLanguageList, contains(LanguageDefined.kLanguageMyMM));
    expect(LANGUAGE_MAP['my'], LanguageDefined.kLanguageMyMM);
    expect(Language.fromCode('my'), LanguageDefined.kLanguageMyMM);
    expect(Language.fromLocale(locale), LanguageDefined.kLanguageMyMM);
    expect(locale.supportedOrNull(), locale);
  });

  test('Myanmar delegate loads translated messages and placeholders', () async {
    const locale = Locale('my', 'MM');

    expect(CoreLocalizations.delegate.isSupported(locale), isTrue);
    final localization = await CoreLocalizations.delegate.load(locale);

    expect(localization.localeName, 'my');
    expect(localization.loginTxtUsername, 'အသုံးပြုသူအမည်');
    expect(localization.loginBtnLogin, 'အကောင့်ဝင်ရန်');
    expect(localization.unsupportedLanguageException('zz'), 'ဘာသာစကား zz ကို မပံ့ပိုးပါ။');
    expect(localization.biometricIOSLocalizedFallbackTitle, isEmpty);
  });

  testWidgets('MaterialApp resolves Myanmar regional locale and renders translations', (tester) async {
    await tester.pumpWidget(MaterialApp(
      locale: const Locale('my', 'MM'),
      supportedLocales: SUPPORTED_LOCALES,
      localizationsDelegates: CoreLocalizations.localizationsDelegates,
      home: Builder(builder: (context) {
        return Text(CoreLocalizations.of(context)!.loginBtnLogin);
      }),
    ));
    await tester.pumpAndSettle();

    expect(tester.takeException(), isNull);
    expect(find.text('အကောင့်ဝင်ရန်'), findsOneWidget);
    expect(Localizations.localeOf(tester.element(find.byType(Text))), const Locale('my'));
  });
}
