import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class AuthInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // 此处根据业务逻辑，自行判断处理
    if ('access_token' != '') {
      options.headers['access_token'] = 'access_token';
    }
    super.onRequest(options, handler);
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
