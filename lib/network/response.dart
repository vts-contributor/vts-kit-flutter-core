import 'package:dio/dio.dart' as dio;

class Response<T> extends dio.Response<T> {
  Response({required dio.RequestOptions requestOptions})
      : super(requestOptions: requestOptions);

  factory Response.fromDio(dio.Response<T> response) {
    return Response(requestOptions: response.requestOptions);
  }
}
