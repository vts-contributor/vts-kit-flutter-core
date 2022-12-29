import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter_core/caches/caches.dart';

import 'api_service.dart';
import 'custom_cancel_token.dart';
import 'response_json.dart';

part 'dio_interceptors.dart';

const int sendTimeout = 60000;
const int receiveTimeout = 60000;
const int connectTimeout = 60000;

Future<V> get<V extends JsonResponse>(String host, String path,
    {Map<String, String>? headers,
    CustomCancelToken? cancelToken,
    Map<String, dynamic>? params,
    InterceptorsWrapper? customInterceptors,
    int sendTimeout = sendTimeout,
    int receiveTimeout = receiveTimeout,
    int connectTimeout = connectTimeout,
    required Function(Response res) parser}) async {
  final dio = prepareDio(interceptors: customInterceptors ?? interceptors);
  dio.options.sendTimeout = sendTimeout;
  dio.options.receiveTimeout = receiveTimeout;
  dio.options.connectTimeout = connectTimeout;
  final response = await dio.get(
    '$host/$path',
    queryParameters: params,
    cancelToken: cancelToken,
    options: Options(headers: headers),
  );
  return parser(response);
}

Future<V> post<V extends JsonResponse>(
  String host,
  String path,
  dynamic body, {
  Map<String, String>? headers,
  CustomCancelToken? cancelToken,
  InterceptorsWrapper? customInterceptors,
  int sendTimeout = sendTimeout,
  int receiveTimeout = receiveTimeout,
  int connectTimeout = connectTimeout,
  required Function(Response res) parser,
}) async {
  final dio = prepareDio(interceptors: customInterceptors ?? interceptors);
  dio.options.connectTimeout = connectTimeout;
  dio.options.receiveTimeout = receiveTimeout;
  dio.options.sendTimeout = sendTimeout;
  final response = await dio.post(
    '$host/$path',
    data: body,
    cancelToken: cancelToken,
    options: Options(headers: headers),
  );
  return parser(response);
}

Future<File> download(
  String url,
  String savePath, {
  CustomCancelToken? cancelToken,
  ProgressCallback? onReceiveProgress,
  InterceptorsWrapper? customInterceptors,
}) async {
  final dio = prepareDio(interceptors: customInterceptors ?? interceptors);
  await dio.download(
    url,
    savePath,
    cancelToken: cancelToken,
    onReceiveProgress: onReceiveProgress,
  );
  File file = File(savePath);
  return file;
}

Dio prepareDio({required InterceptorsWrapper interceptors}) {
  final dio = Dio()..interceptors.add(interceptors);
  (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
      (HttpClient client) {
    client.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    return client;
  };
  return dio;
}
