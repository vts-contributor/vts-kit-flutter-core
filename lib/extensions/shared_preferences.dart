import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_core/models/models.dart';
import 'extension_functions.dart';

extension Tokenx on Token {
  static const _KEY_ACCESS = 'TOKEN_ACCESS';
  static const _KEY_REFRESH = 'TOKEN_REFRESH';
  static const _KEY_TYPE = 'TOKEN_TYPE';
  static const _KEY_EXPIRES = 'TOKEN_EXPIRES';
  static const _KEY_SCOPE = 'TOKEN_SCOPE';

  static Future<Token> fromSharedPreferences() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final access = sharedPreferences.getString(_KEY_ACCESS);
    final refresh = sharedPreferences.getString(_KEY_REFRESH);
    final type = sharedPreferences.getString(_KEY_TYPE);
    final expiresIn = sharedPreferences.getInt(_KEY_EXPIRES);
    final scope = sharedPreferences.getString(_KEY_SCOPE);
    return Token(access, type, refresh, expiresIn, scope);
  }

  Future<void> saveSharedPreferences() async {
    final sharedPref = await SharedPreferences.getInstance();
    await access?.asyncLet((it) => sharedPref.setString(_KEY_ACCESS, it));
    await refresh?.asyncLet((it) => sharedPref.setString(_KEY_REFRESH, it));
    await type?.asyncLet((it) => sharedPref.setString(_KEY_TYPE, it));
    await expiresIn?.asyncLet((it) => sharedPref.setInt(_KEY_EXPIRES, it));
    await scope?.asyncLet((it) => sharedPref.setString(_KEY_SCOPE, it));
  }
}
