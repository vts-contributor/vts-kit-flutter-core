import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/bases/exceptions.dart';
import 'package:flutter_core/localizations/localizations.dart';

extension MultiLangugeException on Exception {
  Exception parseMultiLanguage(BuildContext context) {
    final appLocalization = CoreLocalizations.of(context);

    Exception returnException = CommonException("Error! An error occurred.", rootCause: this);
    if (appLocalization != null) {
      try {
        returnException = CommonException('${appLocalization.commonException}', rootCause: this);
        throw (this);
      } on DioError {
        final DioError dioError = this as DioError;
        switch (dioError.type) {
          case DioErrorType.connectTimeout:
          case DioErrorType.receiveTimeout:
          case DioErrorType.sendTimeout:
            returnException = CoreTimeoutException('${appLocalization.timeoutException}');
            break;
          case DioErrorType.response:
            // no
            break;
          case DioErrorType.cancel:
            returnException = CancelRequestException(
                appLocalization.cancelRequestException,
                reason: dioError.error.toString());
            break;
          case DioErrorType.other:
            final rootException = dioError.error;
            if (rootException is Exception) {
              return rootException.parseMultiLanguage(context);
            }
            //bo qua neu khong xac dinh duoc exception duoc giau trong DioError
        }
      } on SocketException {
        returnException =
            CoreSocketException('${appLocalization.socketException}');
      } on TimeoutException {
        returnException =
            CoreTimeoutException('${appLocalization.timeoutException}');
      } on AuthorizationException {
        returnException =
            AuthorizationException('${appLocalization.authorizationException}');
      } on NotFoundException {
        returnException =
            NotFoundException('${appLocalization.notFoundException}');
      } on UnsupportedLanguageException {
        UnsupportedLanguageException ex = this as UnsupportedLanguageException;
        String languageName = ex.language?.name ?? '';
        returnException = UnsupportedLanguageException(
            '${appLocalization.unsupportedLanguageException(languageName)}',
            ex.language);
      } on NotEnabledBioSecurityException {
        returnException = NotEnabledBioSecurityException(
            appLocalization.bioSecurityNotEnabled);
      } on ImplicitServerResponseError {
        returnException =
            ServerResponseError('${appLocalization.commonException}');
      } on ServerResponseError {
        //bo qua neu la message tu server
      } on Exception {
        returnException = CommonException('${appLocalization.commonException}', rootCause: this);
      } on NoSuchMethodError {
        returnException = CommonException('${appLocalization.noSuchMethodException}', rootCause: this);
      }
    }
    return returnException;
  }
}
