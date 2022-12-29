import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_core/network/custom_cancel_token.dart';
import 'package:flutter_core/network/response_json.dart';
import 'package:flutter_core/network/dio_network.dart' as dio_network;

abstract class AbstractServerLog {
  static const int sendTimeout = 5000;
  static const int receiveTimeout = 5000;
  static const int connectTimeout = 5000;

  @protected
  abstract final String host;

  @protected
  abstract final String path;

  @protected
  abstract final HttpMethod sendMethod;

  @protected
  abstract final StoredIn logStoredIn;

  @protected
  JsonResponse parseJsonFun(Response response) =>
      JsonResponse(content: {'response': response});

  @protected
  final InterceptorsWrapper interceptors = InterceptorsWrapper();

  Future<void> sendLog(
    Map<String, dynamic> log, {
    String? customPath,
    StoredIn? logStoredIn,
    HttpMethod? sendMethod,
  }) async {
    try {
      if (sendMethod == null) {
        sendMethod = this.sendMethod;
      }
      if (logStoredIn == null) {
        logStoredIn = this.logStoredIn;
      }
      if (sendMethod == HttpMethod.GET) {
        if (logStoredIn == StoredIn.HEADER) {
          await get(
              path: customPath,
              headers:
                  log.map((key, value) => MapEntry(key, value.toString())));
        } else {
          await get(path: customPath, params: log);
        }
      } else {
        if (logStoredIn == StoredIn.HEADER) {
          await post(
            path: customPath,
            headers: log.map(
              (key, value) => MapEntry(key, value.toString()),
            ),
          );
        } else {
          await post(path: customPath, body: log);
        }
      }
    } on Exception catch (e) {
      print('ServerLog send failed: $e}');
    }
  }

  @protected
  Future<V?> get<V extends JsonResponse>(
      {String? path,
      Map<String, String>? headers,
      CustomCancelToken? cancelToken,
      Map<String, dynamic>? params,
      InterceptorsWrapper? customInterceptors,
      int sendTimeout = sendTimeout,
      int receiveTimeout = receiveTimeout,
      int connectTimeout = connectTimeout,
      Function(Response res)? parser}) async {
    try {
      final result = await dio_network.get<V>(
        host,
        path ?? this.path,
        parser: parser ?? parseJsonFun,
        cancelToken: cancelToken,
        params: params,
        customInterceptors: interceptors,
        sendTimeout: sendTimeout,
        receiveTimeout: receiveTimeout,
        connectTimeout: connectTimeout,
      );
      return result;
    } on Exception catch (e) {
      print(e);
    }
    return null;
  }

  @protected
  Future<V?> post<V extends JsonResponse>(
      {String? path,
      Map<String, String>? headers,
      dynamic body,
      CustomCancelToken? cancelToken,
      InterceptorsWrapper? customInterceptors,
      int sendTimeout = sendTimeout,
      int receiveTimeout = receiveTimeout,
      int connectTimeout = connectTimeout,
      Function(Response res)? parser}) async {
    try {
      final result = await dio_network.post<V>(
        host,
        path ?? this.path,
        body,
        parser: parser ?? parseJsonFun,
        cancelToken: cancelToken,
        customInterceptors: interceptors,
        sendTimeout: sendTimeout,
        receiveTimeout: receiveTimeout,
        connectTimeout: connectTimeout,
      );
      return result;
    } on Exception catch (e) {
      print(e);
      rethrow;
    }
  }
}

enum HttpMethod { GET, POST }

enum StoredIn { HEADER, PARAM_BODY }
