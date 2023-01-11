import 'core.dart';

/// The translations for English (`en`).
class CoreLocalizationsEn extends CoreLocalizations {
  CoreLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get loginTxtUsername => 'User name';

  @override
  String get loginTxtPassword => 'Password';

  @override
  String get loginBtnLogin => 'Login';

  @override
  String get loginWithFingerprint => 'Log in with Fingerprint';

  @override
  String get loginWithFaceId => 'Log in Face ID';

  @override
  String get bioSecurityNotEnabled => 'Biometric security not enabled, please turn it on';

  @override
  String get loginAltEmptyUserNamePassword => 'Username and password cannot be null';

  @override
  String get loginAlrLoading => 'Authenticating';

  @override
  String get loadAccessControl => 'Loading access control policy';

  @override
  String get socketException => 'No internet, please try again';

  @override
  String get timeoutException => 'Time out to process the request';

  @override
  String get authorizationException => 'Authorization error, please login again';

  @override
  String get notFoundException => 'Content not found, please come back later';

  @override
  String unsupportedLanguageException(Object argument) {
    return 'Language $argument is not supported';
  }

  @override
  String get commonException => 'Error! An error occurred, please try again later';

  @override
  String get noSuchMethodException => 'An error occurred while retrieving data';

  @override
  String get notFoundPageInStreamChannel => 'Not found page in stream';

  @override
  String get emptyStreamChannel => 'Stream channel can not empty';

  @override
  String get cancelRequestException => 'Task is canceled';

  @override
  String get biometricAuthLocalizedReason => 'Let OS determine authentication method';

  @override
  String get biometricHint => 'Verify identity';

  @override
  String get biometricNotRecognized => 'Not recognized. Try again.';

  @override
  String get biometricRequiredTitle => 'Biometric required';

  @override
  String get biometricSuccess => 'Success';

  @override
  String get biometricOkButton => 'OK';

  @override
  String get biometricCancelButton => 'Cancel';

  @override
  String get biometricDeviceCredentialsRequiredTitle => 'Device credentials required';

  @override
  String get biometricDeviceCredentialsSetupDescription => 'Device credentials required';

  @override
  String get biometricGoToSettingsButton => 'Go to settings';

  @override
  String get biometricGoToSettingsDescription => 'Biometric authentication is not set up on your device. Go to \'Settings > Security\' to add biometric authentication.';

  @override
  String get biometricIOSGoToSettingsDescription => 'Biometric authentication is not set up on your device. Please either enable Touch ID or Face ID on your phone.';

  @override
  String get biometricSignInTitle => 'Authentication required';

  @override
  String get biometricLockOut => 'Biometric authentication is disabled. Please lock and unlock your screen to enable it.';

  @override
  String get biometricIOSLocalizedFallbackTitle => '';
}
