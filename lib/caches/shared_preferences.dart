part of caching;


class _SharedPreferencesCache {
  static Future<bool> isLogged() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final isLogged = sharedPreferences.getBool('IS_LOGGED') ?? false;
    return isLogged;
  }

  static Future<void> saveLogged(bool value) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setBool('IS_LOGGED', value);
  }

  static Future<String?> getLoggedUsername() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final username = sharedPreferences.getString('LOGGED_USERNAME');
    return username;
  }

  static Future<void> setLoggedUsername(String value) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString('LOGGED_USERNAME', value);
  }
  static Future<int?> getLoggedUserId() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final username = sharedPreferences.getInt('LOGGED_USERID');
    return username;
  }

  static Future<void> setLoggedUserId(int value) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setInt('LOGGED_USERID', value);
  }

  static Future<bool> isUseBiometric() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final useBiometric = sharedPreferences.getBool('USE_BIOMETRIC') ?? true;
    return useBiometric;
  }

  static Future<void> setUseBiometric(bool value) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setBool('USE_BIOMETRIC', value);
  }

  static Future<Token> getToken() => Tokenx.fromSharedPreferences();

  static Future<void> setToken(Token token) => token.saveSharedPreferences();
}
