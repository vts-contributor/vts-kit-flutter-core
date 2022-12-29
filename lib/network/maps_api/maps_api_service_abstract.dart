import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_core/bases/bases.dart';
import 'package:flutter_core/extensions/extensions.dart';
import 'package:flutter_core/models/maps_api/maps_api.dart';
import 'package:flutter_core/network/custom_cancel_token.dart';
import 'package:flutter_core/network/dio_network.dart' as dio_network;
import 'package:flutter_core/network/maps_api/maps_api.dart';

abstract class MapsAPIAbstractService {
  @protected
  abstract MapAPIConfig config;
  @protected
  abstract MapsAPIResponseParser jsonParser;

  MapsAPIResponse _parseJsonFun(Response response) => jsonParser.parse(response);

  @protected
  Future<V> get<V extends MapsAPIResponse>(String path,
      {Map<String, String>? headers,
      CustomCancelToken? cancelToken,
      Map<String, dynamic>? params,
      InterceptorsWrapper? customInterceptors,
      int sendTimeout = dio_network.sendTimeout,
      int receiveTimeout = dio_network.receiveTimeout,
      int connectTimeout = dio_network.connectTimeout,
      Function(Response res)? parser}) async {
    try {
      if (config.key.isNullOrEmpty) {
        throw Exception('Not found Maps key');
      }
      final InterceptorsWrapper interceptors;
      if (customInterceptors == null) {
        interceptors = MapsAPIInterceptorsWrapper()..config = this.config;
      } else {
        interceptors = customInterceptors;
      }
      final result = await dio_network.get<V>(
        this.config.hostOf(path),
        path,
        parser: parser ?? _parseJsonFun,
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
      rethrow;
    }
  }
}
