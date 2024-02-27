import 'package:dio/dio.dart';

class NetworkInterceptors extends InterceptorsWrapper {
  NetworkInterceptors({
    InterceptorSendCallback? onRequest,
    InterceptorSuccessCallback? onResponse,
    InterceptorErrorCallback? onError,
  }) : super(onRequest: onRequest, onResponse: onResponse, onError: onError) {}
}
