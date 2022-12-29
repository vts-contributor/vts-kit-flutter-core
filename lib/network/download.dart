import 'dart:io';

import 'package:dio/dio.dart';
import 'dio_network.dart' as dio_network;
import 'custom_cancel_token.dart';

Future<File> download(String url, String savePath,
        {CustomCancelToken? cancelToken, ProgressCallback? onReceiveProgress}) =>
    dio_network.download(url, savePath,
        cancelToken: cancelToken, onReceiveProgress: onReceiveProgress);
