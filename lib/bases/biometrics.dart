import 'package:flutter/services.dart';
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

  Future<bool> authenticate() async {
    final auth = LocalAuthentication();
    bool authenticated = false;
    try {
      authenticated = await auth.authenticate(
          localizedReason: 'Let OS determine authentication method',
          useErrorDialogs: true,
          biometricOnly: true,
          stickyAuth: true);
    } on PlatformException {
      throw NotEnabledBioSecurityException('');
    }
    return authenticated;
  }
}
