import 'package:dio/dio.dart';

class Interceptors extends InterceptorsWrapper {
  Interceptors({
    InterceptorSendCallback? onRequest,
    InterceptorSuccessCallback? onResponse,
    InterceptorErrorCallback? onError,
  }) : super(onRequest: onRequest, onResponse: onResponse, onError: onError) {}
}
