part of 'dio_network.dart';

InterceptorsWrapper get interceptors =>
    InterceptorsWrapper(onRequest: onRequestHandle, onError: onErrorHandle);

void onRequestHandle(
    RequestOptions options, RequestInterceptorHandler handler) {
  if (!options.headers.containsKey(Headers.contentTypeHeader)) {
    options.headers[Headers.contentTypeHeader] = Headers.jsonContentType;
  }
  options.headers['authorization'] = 'Bearer ${Profile.token?.access}';
  handler.next(options);
}

void onErrorHandle(DioError error, ErrorInterceptorHandler handler) async {
  final response = error.response;
  if (response?.statusCode == 403) {
    final requestOptions = response?.requestOptions;
    await CoreAPIService.refreshToken();
    final dio = prepareDio(interceptors: interceptors);
    if (requestOptions != null) {
      final headerWithoutContentLength = requestOptions.headers
        ..remove(Headers.contentLengthHeader);
      final successResponse = await dio.request(
        requestOptions.path,
        data: requestOptions.data,
        queryParameters: requestOptions.queryParameters,
        options: Options(
            headers: headerWithoutContentLength, method: requestOptions.method),
      );
      handler.resolve(successResponse);
    }
  }
  handler.next(error);
}
