import 'package:flutter_core/models/language.dart';

class CoreSocketException implements Exception {
  final String message;

  CoreSocketException(this.message);

  @override
  String toString() => message;
}

class CoreTimeoutException implements Exception {
  final String message;

  CoreTimeoutException(this.message);

  @override
  String toString() => message;
}

class AuthorizationException implements Exception {
  final String message;
  final String? invalidToken;

  AuthorizationException(this.message, {this.invalidToken});

  @override
  String toString() => message;
}

class ServerResponseError implements Exception {
  final String message;

  ServerResponseError(this.message);

  @override
  String toString() => message;
}

class NotFoundException implements Exception {
  final String message;

  NotFoundException(this.message);

  @override
  String toString() => message;
}

class UnsupportedLanguageException implements Exception {
  final String message;
  final Language? language;

  UnsupportedLanguageException(this.message, this.language);

  @override
  String toString() => message;
}

class NotEnabledBioSecurityException implements Exception {
  final String message;

  NotEnabledBioSecurityException(this.message);

  @override
  String toString() => message;
}

class NotInitializedException implements Exception {
  final String message;

  NotInitializedException(this.message);

  @override
  String toString() => message;
}

class NoMoreOneInstanceException implements Exception{
  final String message;

  NoMoreOneInstanceException(this.message);

  @override
  String toString() => message;
}

class ImplicitServerResponseError extends ServerResponseError {
  final Exception rootCause;

  ImplicitServerResponseError({required this.rootCause}) : super('');
}

class CancelRequestException implements Exception {
  final String message;
  final String? action;
  final String? reason;

  CancelRequestException(this.message, {this.action, this.reason});

  @override
  String toString() {
    return message;
  }
}

class CommonException implements Exception {
  final String message;
  final Exception rootCause;

  CommonException(this.message, {required this.rootCause});

  @override
  String toString() => message;
}
