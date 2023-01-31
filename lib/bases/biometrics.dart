import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_core/localizations/generated/core.dart';
import 'package:local_auth/auth_strings.dart';
import 'package:local_auth/local_auth.dart';
import 'exceptions.dart';

class BiometricAuth {
  Future<bool> canCheckBiometrics() async {
    final auth = LocalAuthentication();
    late bool canCheckBiometrics;
    try {
      canCheckBiometrics = await auth.canCheckBiometrics;
    } on PlatformException catch (ex) {
      canCheckBiometrics = false;
      print('canCheckBiometrics exception $ex');
    }
    return canCheckBiometrics;
  }

  Future<List<BiometricType>> getAvailableBiometrics() async {
    final auth = LocalAuthentication();
    late List<BiometricType> biometricTypeList;
    try {
      biometricTypeList = await auth.getAvailableBiometrics();
    } on PlatformException catch (ex) {
      biometricTypeList = [];
      print('getAvailableBiometrics exception $ex');
    }
    return biometricTypeList;
  }

  Future<bool> authenticate({BuildContext? context}) async {
    final auth = LocalAuthentication();
    bool authenticated = false;

    CoreLocalizations? l10n;
    AndroidAuthMessages? androidAuthMessages;
    IOSAuthMessages? iosAuthMessages;
    if (context != null) {
      l10n = CoreLocalizations.of(context);
      if (l10n != null) {
        androidAuthMessages = AndroidAuthMessages(
          biometricHint: l10n.biometricHint,
          biometricNotRecognized: l10n.biometricNotRecognized,
          biometricRequiredTitle: l10n.biometricRequiredTitle,
          biometricSuccess: l10n.biometricSuccess,
          cancelButton: l10n.biometricCancelButton,
          deviceCredentialsRequiredTitle: l10n.biometricDeviceCredentialsRequiredTitle,
          deviceCredentialsSetupDescription: l10n.biometricDeviceCredentialsSetupDescription,
          goToSettingsButton: l10n.biometricGoToSettingsButton,
          goToSettingsDescription: l10n.biometricGoToSettingsDescription,
          signInTitle: l10n.biometricSignInTitle,
        );
        iosAuthMessages = IOSAuthMessages(
          lockOut: l10n.biometricLockOut,
          goToSettingsDescription: l10n.biometricIOSGoToSettingsDescription,
          goToSettingsButton: l10n.biometricGoToSettingsButton,
          cancelButton: l10n.biometricOkButton,
          localizedFallbackTitle: l10n.biometricIOSLocalizedFallbackTitle,
        );
      }
    }

    try {
      authenticated = await auth.authenticate(
          localizedReason: l10n?.biometricAuthLocalizedReason ?? 'Let OS determine authentication method',
          iOSAuthStrings: iosAuthMessages ?? const IOSAuthMessages(),
          androidAuthStrings: androidAuthMessages ?? const AndroidAuthMessages(),
          useErrorDialogs: true,
          biometricOnly: true,
          stickyAuth: true);
    } on PlatformException {
      throw NotEnabledBioSecurityException('');
    }
    return authenticated;
  }
}
