import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'api_service.dart';
import 'response_json.dart';
import 'package:flutter_core/models/models.dart';
import 'package:flutter_core/bases/bases.dart';
import 'package:flutter_core/caches/caches.dart';
import 'package:http/http.dart' as http;

const int MAX_RETRY = 3;
const int TIMEOUT_SECOND = 300;
const BASIC_AUTHORIZATION = 'Basic YnJvd3Nlcjo=';

//Not implemented
Future<Token> _refreshToken() async {
  final Map<String, dynamic> params = {};
  final response = await http
      .get(Uri.http(CoreAPIService.host, 'uaa/oauth/refresh_token', params));
  if (response.statusCode == 200) {
    final token = Token.fromJson(jsonDecode(response.body));
    await Profile.setToken(token);
    return token;
  } else {
    throw AuthorizationException(
        '${Profile.token?.refresh} can not refresh token');
  }
}

Future<JsonResponse> get(String host, String path,
        {Map<String, String>? headers, Map<String, dynamic>? params}) =>
    _request(host, path, 'GET', appendHeaders: headers, params: params);

Future<JsonResponse> post(String host, String path, Map<String, dynamic> body,
        {Map<String, String>? headers}) =>
    _request(host, path, 'POST', appendHeaders: headers, body: body);

Future<JsonResponse> _request(String host, String path, String method,
    {Map<String, String>? appendHeaders,
    Map<String, dynamic>? params,
    Map<String, dynamic>? body,
    int retried = 0}) async {
  final headers = defaultHeaders()..addAll(appendHeaders ?? {});
  final Uri uri = Uri.http(host, path, params);
  final http.Response response = await sendRequest(method, uri, headers, body);
  final JsonResponse jsonResponse = JsonResponse.fromResponse(response);
  switch (jsonResponse.errorCode) {
    case 200:
      break;
    case 401:
      if (retried < MAX_RETRY) {
        await _refreshToken();
        return await _request(host, path, method,
            params: params, body: body, retried: retried + 1);
      } else {
        print('CAN NOT retry $host/$path \r\n $method');
        throw AuthorizationException('max retry request');
      }
    case 404:
      throw NotFoundException('not found $host/$path');
    default:
      throw ServerResponseError('${jsonResponse.errorMessage}');
  }
  return jsonResponse;
}

Map<String, String> defaultHeaders() => {
      HttpHeaders.contentTypeHeader: ContentType.json.value,
      HttpHeaders.authorizationHeader:
          "${Profile.token?.type} ${Profile.token?.access}"
    };

String parseBody(Map<String, String> headers, Map<String, dynamic>? mapBody) {
  if (mapBody == null) {
    return '';
  }
  String? contentType = headers[HttpHeaders.contentTypeHeader];
  String body;
  switch (contentType) {
    case 'application/x-www-form-urlencoded':
      body = _xWWWFormUrlEncodedBody(mapBody);
      headers[HttpHeaders.contentLengthHeader] = body.length.toString();
      break;
    case 'application/json':
    default:
      body = _rawJsonBody(mapBody);
  }
  return body;
}

String _rawJsonBody(Map<String, dynamic> mapBody) => jsonEncode(mapBody);

String _xWWWFormUrlEncodedBody(Map<String, dynamic> mapBody) =>
    mapBody.keys.map((key) => "$key=${mapBody[key]}").join("&");

Future<http.Response> sendRequest(String method, Uri uri,
    Map<String, String> headers, Map<String, dynamic>? mapBody) async {
  final http.Response response;
  switch (method) {
    case 'GET':
      response = await http
          .get(uri, headers: headers)
          .timeout(Duration(seconds: TIMEOUT_SECOND));
      break;
    case 'POST':
    default:
      String parsedBody = parseBody(headers, mapBody);
      response = await http
          .post(uri, headers: headers, body: parsedBody)
          .timeout(Duration(seconds: TIMEOUT_SECOND));
  }
  return response;
}
