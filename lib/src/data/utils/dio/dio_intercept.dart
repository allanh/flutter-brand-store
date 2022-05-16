import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../storage/my_key.dart';
import '../storage/secure_storage.dart';

class AuthInterceptor extends Interceptor {
  final _storage = SecureStorage();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    _storage.read(MyKey.auth).then((token) {
      if (token != null && token.isNotEmpty) {
        options.headers['authorization'] = token;
      }
    }).whenComplete(() => super.onRequest(options, handler));
  }
}

class LogInterceptor extends Interceptor {
  late DateTime _startTime;
  late DateTime _endTime;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    _startTime = DateTime.now();
    debugPrint('---Request Start---');
    debugPrint('uri: ${options.uri}');
    debugPrint('header: ${options.headers}');
    debugPrint('param: ${options.queryParameters}');
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    _endTime = DateTime.now();
    final int duration = _endTime.difference(_startTime).inMilliseconds;
    debugPrint('---Request End: 耗時 $duration 毫秒---');
    super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    debugPrint('---Resuest Error: ${err.toString()}');
    super.onError(err, handler);
  }
}
