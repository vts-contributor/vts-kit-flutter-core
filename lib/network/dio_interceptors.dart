part of 'network.dart';

interceptor.Interceptors get interceptors => interceptor.Interceptors(
    onRequest: onRequestHandle, onError: onErrorHandle);

void onRequestHandle(
    dio_pkg.RequestOptions options, dio_pkg.RequestInterceptorHandler handler) {
  if (!options.headers.containsKey(dio_pkg.Headers.contentTypeHeader)) {
    options.headers[dio_pkg.Headers.contentTypeHeader] =
        dio_pkg.Headers.jsonContentType;
  }
  options.headers['authorization'] = 'Bearer ${Profile.token?.access}';
  handler.next(options);
}

void onErrorHandle(
    dio_pkg.DioError error, dio_pkg.ErrorInterceptorHandler handler) async {
  final response = error.response;
  if (response?.statusCode == 403) {
    final requestOptions = response?.requestOptions;
    await CoreAPIService.refreshToken();
    final dio = prepareDio(interceptors: interceptors);
    if (requestOptions != null) {
      final headerWithoutContentLength = requestOptions.headers
        ..remove(dio_pkg.Headers.contentLengthHeader);
      final successResponse = await dio.request(
        requestOptions.path,
        data: requestOptions.data,
        queryParameters: requestOptions.queryParameters,
        options: dio_pkg.Options(
            headers: headerWithoutContentLength, method: requestOptions.method),
      );
      handler.resolve(successResponse);
    }
  }
  handler.next(error);
}
