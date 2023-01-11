import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'core_en.dart';
import 'core_vi.dart';

/// Callers can lookup localized strings with an instance of CoreLocalizations
/// returned by `CoreLocalizations.of(context)`.
///
/// Applications need to include `CoreLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/core.dart';
///
/// return MaterialApp(
///   localizationsDelegates: CoreLocalizations.localizationsDelegates,
///   supportedLocales: CoreLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the CoreLocalizations.supportedLocales
/// property.
abstract class CoreLocalizations {
  CoreLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static CoreLocalizations? of(BuildContext context) {
    return Localizations.of<CoreLocalizations>(context, CoreLocalizations);
  }

  static const LocalizationsDelegate<CoreLocalizations> delegate = _CoreLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('vi')
  ];

  /// No description provided for @loginTxtUsername.
  ///
  /// In en, this message translates to:
  /// **'User name'**
  String get loginTxtUsername;

  /// No description provided for @loginTxtPassword.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get loginTxtPassword;

  /// No description provided for @loginBtnLogin.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get loginBtnLogin;

  /// No description provided for @loginWithFingerprint.
  ///
  /// In en, this message translates to:
  /// **'Log in with Fingerprint'**
  String get loginWithFingerprint;

  /// No description provided for @loginWithFaceId.
  ///
  /// In en, this message translates to:
  /// **'Log in Face ID'**
  String get loginWithFaceId;

  /// No description provided for @bioSecurityNotEnabled.
  ///
  /// In en, this message translates to:
  /// **'Biometric security not enabled, please turn it on'**
  String get bioSecurityNotEnabled;

  /// No description provided for @loginAltEmptyUserNamePassword.
  ///
  /// In en, this message translates to:
  /// **'Username and password cannot be null'**
  String get loginAltEmptyUserNamePassword;

  /// No description provided for @loginAlrLoading.
  ///
  /// In en, this message translates to:
  /// **'Authenticating'**
  String get loginAlrLoading;

  /// No description provided for @loadAccessControl.
  ///
  /// In en, this message translates to:
  /// **'Loading access control policy'**
  String get loadAccessControl;

  /// No description provided for @socketException.
  ///
  /// In en, this message translates to:
  /// **'No internet, please try again'**
  String get socketException;

  /// No description provided for @timeoutException.
  ///
  /// In en, this message translates to:
  /// **'Time out to process the request'**
  String get timeoutException;

  /// No description provided for @authorizationException.
  ///
  /// In en, this message translates to:
  /// **'Authorization error, please login again'**
  String get authorizationException;

  /// No description provided for @notFoundException.
  ///
  /// In en, this message translates to:
  /// **'Content not found, please come back later'**
  String get notFoundException;

  /// No description provided for @unsupportedLanguageException.
  ///
  /// In en, this message translates to:
  /// **'Language {argument} is not supported'**
  String unsupportedLanguageException(Object argument);

  /// No description provided for @commonException.
  ///
  /// In en, this message translates to:
  /// **'Error! An error occurred, please try again later'**
  String get commonException;

  /// No description provided for @noSuchMethodException.
  ///
  /// In en, this message translates to:
  /// **'An error occurred while retrieving data'**
  String get noSuchMethodException;

  /// No description provided for @notFoundPageInStreamChannel.
  ///
  /// In en, this message translates to:
  /// **'Not found page in stream'**
  String get notFoundPageInStreamChannel;

  /// No description provided for @emptyStreamChannel.
  ///
  /// In en, this message translates to:
  /// **'Stream channel can not empty'**
  String get emptyStreamChannel;

  /// No description provided for @cancelRequestException.
  ///
  /// In en, this message translates to:
  /// **'Task is canceled'**
  String get cancelRequestException;

  /// No description provided for @biometricAuthLocalizedReason.
  ///
  /// In en, this message translates to:
  /// **'Let OS determine authentication method'**
  String get biometricAuthLocalizedReason;

  /// No description provided for @biometricHint.
  ///
  /// In en, this message translates to:
  /// **'Verify identity'**
  String get biometricHint;

  /// No description provided for @biometricNotRecognized.
  ///
  /// In en, this message translates to:
  /// **'Not recognized. Try again.'**
  String get biometricNotRecognized;

  /// No description provided for @biometricRequiredTitle.
  ///
  /// In en, this message translates to:
  /// **'Biometric required'**
  String get biometricRequiredTitle;

  /// No description provided for @biometricSuccess.
  ///
  /// In en, this message translates to:
  /// **'Success'**
  String get biometricSuccess;

  /// No description provided for @biometricOkButton.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get biometricOkButton;

  /// No description provided for @biometricCancelButton.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get biometricCancelButton;

  /// No description provided for @biometricDeviceCredentialsRequiredTitle.
  ///
  /// In en, this message translates to:
  /// **'Device credentials required'**
  String get biometricDeviceCredentialsRequiredTitle;

  /// No description provided for @biometricDeviceCredentialsSetupDescription.
  ///
  /// In en, this message translates to:
  /// **'Device credentials required'**
  String get biometricDeviceCredentialsSetupDescription;

  /// No description provided for @biometricGoToSettingsButton.
  ///
  /// In en, this message translates to:
  /// **'Go to settings'**
  String get biometricGoToSettingsButton;

  /// No description provided for @biometricGoToSettingsDescription.
  ///
  /// In en, this message translates to:
  /// **'Biometric authentication is not set up on your device. Go to \'Settings > Security\' to add biometric authentication.'**
  String get biometricGoToSettingsDescription;

  /// No description provided for @biometricIOSGoToSettingsDescription.
  ///
  /// In en, this message translates to:
  /// **'Biometric authentication is not set up on your device. Please either enable Touch ID or Face ID on your phone.'**
  String get biometricIOSGoToSettingsDescription;

  /// No description provided for @biometricSignInTitle.
  ///
  /// In en, this message translates to:
  /// **'Authentication required'**
  String get biometricSignInTitle;

  /// No description provided for @biometricLockOut.
  ///
  /// In en, this message translates to:
  /// **'Biometric authentication is disabled. Please lock and unlock your screen to enable it.'**
  String get biometricLockOut;

  /// No description provided for @biometricIOSLocalizedFallbackTitle.
  ///
  /// In en, this message translates to:
  /// **''**
  String get biometricIOSLocalizedFallbackTitle;
}

class _CoreLocalizationsDelegate extends LocalizationsDelegate<CoreLocalizations> {
  const _CoreLocalizationsDelegate();

  @override
  Future<CoreLocalizations> load(Locale locale) {
    return SynchronousFuture<CoreLocalizations>(lookupCoreLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'vi'].contains(locale.languageCode);

  @override
  bool shouldReload(_CoreLocalizationsDelegate old) => false;
}

CoreLocalizations lookupCoreLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return CoreLocalizationsEn();
    case 'vi': return CoreLocalizationsVi();
  }

  throw FlutterError(
    'CoreLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
