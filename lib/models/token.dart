import 'abstract.dart';

class Token extends AbstractModel {
  final String? access;
  final String? type;
  final String? refresh;
  final int? expiresIn;
  final String? scope;

  Token(this.access, this.type, this.refresh, this.expiresIn, this.scope);

  factory Token.fromJson(Map<String, dynamic>? json) {
    String? access = json?['access_token'];
    String? type = json?['token_type'];
    String? refresh = json?['refresh_token'];
    int? expiresIn = json?['expires_in'];
    String? scope = json?['scope'];
    return Token(access, type, refresh, expiresIn, scope);
  }
}
