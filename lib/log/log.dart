import 'package:flutter/material.dart';
import 'package:flutter_core/extensions/extensions.dart';

class Log {
  static String? appId;
  static int stackTraceMaxLength = 1000;

  static void i(String tag, String message,
      {Exception? throwable, StackTrace? stackTrace}) {
    final text = formattedLog('I', tag, message,
        throwable: throwable, stackTrace: stackTrace);
    debugPrint('\x1B[30m$text\x1B[0m');
  }

  static void d(String tag, String message,
      {Exception? throwable, StackTrace? stackTrace}) {
    final text = formattedLog('D', tag, message,
        throwable: throwable, stackTrace: stackTrace);
    debugPrint('\x1B[34m$text\x1B[0m');
  }

  static void w(String tag, String message,
      {Exception? throwable, StackTrace? stackTrace}) {
    final text = formattedLog('W', tag, message,
        throwable: throwable, stackTrace: stackTrace);
    debugPrint('\x1B[33m$text\x1B[0m');
  }

  static void e(String tag, String message,
      {Exception? throwable, StackTrace? stackTrace}) {
    final text = formattedLog('I', tag, message,
        throwable: throwable, stackTrace: stackTrace);
    debugPrint('\x1B[31m$text\x1B[0m');
  }

  static String formattedLog(
      String type,
      String tag,
      String message, {
        Exception? throwable,
        StackTrace? stackTrace,
      }) {
    final now = DateTime.now();
    final id = appId?.let((it) => ' $it') ?? '';
    final msg = 'Message: $message';
    final error = throwable?.let((it) => '\r\n$tag: Error: $throwable') ?? '';
    final stackTraceMaxLength = stackTrace
        ?.toString()
        .length
        .takeIf((it) => it < Log.stackTraceMaxLength) ??
        Log.stackTraceMaxLength;
    final stackTraceString = stackTrace
        ?.toString()
        .takeIf((it) => it.length > 0)
        ?.substring(0, stackTraceMaxLength - 1)
        .let((it) => '\r\n$tag: Stacktrace: ~~~~~~~~~~~~\r\n$it\r\n~~~~~~~~~~~~') ??
        '';
    return '$type/$now$id $tag: $msg$error$stackTraceString';
  }
}
