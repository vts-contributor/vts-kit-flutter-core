import 'dart:io';

import 'package:dio/dio.dart';

import 'custom_cancel_token.dart';
import 'network.dart' as network;

Future<File> download(String url, String savePath,
        {CustomCancelToken? cancelToken,
        ProgressCallback? onReceiveProgress}) =>
    network.download(url, savePath,
        cancelToken: cancelToken, onReceiveProgress: onReceiveProgress);
