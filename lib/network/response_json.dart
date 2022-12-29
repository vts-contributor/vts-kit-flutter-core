import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_core/models/abstract.dart';
import 'package:dio/dio.dart';

class JsonResponse {
  final Map<String, dynamic>? content;
  final String? errorMessage;
  final int? errorCode;

  JsonResponse({this.content, this.errorCode, this.errorMessage});

  factory JsonResponse.fromResponse(http.Response response) {
    JsonResponse responseJson;
    try {
      if (response.statusCode == 401) {
        //unauthorized response
        responseJson = JsonResponse(errorCode: response.statusCode);
      } else {
        final Map<String, dynamic> bodyJson =
            jsonDecode(utf8.decode(response.bodyBytes));
        if (bodyJson.containsKey('result')) {
          final resultJson = bodyJson['result'];
          responseJson = JsonResponse(
              content: resultJson['response'],
              errorCode: resultJson['errorCode'],
              errorMessage: resultJson['errorMessage']);
        } else {
          String? errorMessage;
          if (bodyJson.containsKey('error_description')) {
            errorMessage = bodyJson['error_description'];
          }
          responseJson = JsonResponse(
              content: bodyJson,
              errorCode: response.statusCode,
              errorMessage: errorMessage);
        }
      }
    } catch (err) {
      print(
          'parse json fail {body:${response.body}, code:${response.statusCode}  $err');
      responseJson = JsonResponse(
          errorCode: response.statusCode, errorMessage: response.body);
    }
    return responseJson;
  }

  factory JsonResponse.fromDioResponse(Response response) {
    JsonResponse responseJson;
    try {
      if (response.statusCode == 401) {
        //unauthorized response
        responseJson = JsonResponse(errorCode: response.statusCode);
      } else {
        final Map<String, dynamic> bodyJson = response.data;
        if (bodyJson.containsKey('result')) {
          final resultJson = bodyJson['result'];
          responseJson = JsonResponse(
              content: resultJson['response'],
              errorCode: resultJson['errorCode'],
              errorMessage: resultJson['errorMessage']);
        } else {
          String? errorMessage;
          if (bodyJson.containsKey('error_description')) {
            errorMessage = bodyJson['error_description'];
          }
          responseJson = JsonResponse(
              content: bodyJson,
              errorCode: response.statusCode,
              errorMessage: errorMessage);
        }
      }
    } catch (err) {
      print(
          'parse json fail {body:${response.data}, code:${response.statusCode}  $err');
      responseJson = JsonResponse(
          errorCode: response.statusCode, errorMessage: response.data);
    }
    return responseJson;
  }

  T map<T extends AbstractModel>(T fun(Map<String, dynamic>? json)) =>
      fun(content);
}
