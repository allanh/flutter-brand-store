import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import 'api.dart';
import 'base_res.dart';
import 'dio_intercept.dart' as interceptor;
import 'dio_wrapper.dart';

class HttpUtils {
  static final HttpUtils _instance = HttpUtils._();

  static HttpUtils get instance => HttpUtils();

  factory HttpUtils() => _instance;

  static late Dio _dio;

  Dio get dio => _dio;

  HttpUtils._() {
    // 構造 Dio options
    final BaseOptions options = BaseOptions(
        connectTimeout: 15000,
        receiveTimeout: 15000,
        sendTimeout: 10000,
        responseType: ResponseType.plain,
        validateStatus: (_) => true,
        baseUrl: Api.baseUrl,
        headers: {
          // "authorization": "Bearer <your token>",
          'content-Type': 'application/json',
          'brand_id': 5,
          'device': Platform.isIOS ? "ios" : "android",
        });

    // 實例化 Dio
    _dio = Dio(options);

    // 忽略 https 證書校驗
    (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };

    // 添加迭代器
    _dio.interceptors.add(interceptor.AuthInterceptor());
    if (kDebugMode) {
      _dio.interceptors.add(interceptor.LogInterceptor());
    }
  }

  Future<BaseResponse> _request(
    String url, {
    String? method = 'POST',
    dynamic params,
    bool tips = false,
    void Function(int, int)? onSendProgress,
    void Function(int, int)? onReceiveProgress,
  }) async {
    late BaseResponse response;
    try {
      if (tips) {
        // 顯示 loading
      }
      late Response<dynamic> res;
      if (method == 'GET') {
        res = await _dio.get(url, queryParameters: params);
      } else if (method == 'UPLOAD') {
        FormData formData = FormData.fromMap(params);
        res = await _dio.post(
          url,
          data: formData,
          onSendProgress: onSendProgress,
          onReceiveProgress: onReceiveProgress,
        );
      } else {
        res = await _dio.post(
          url,
          data: params,
        );
      }
      response = DioWrapper.responseWrapper(res);
    } catch (e) {
      response = DioWrapper.errorWrapper(e);
    } finally {
      // 隱藏 loading
    }
    return response;
  }

  // GET
  Future<BaseResponse> get(
    String url, {
    dynamic params,
    bool tips = false,
  }) async {
    return _request(
      url,
      method: 'GET',
      params: params,
      tips: tips,
    );
  }

  // POST
  Future<BaseResponse> post(
    String url, {
    dynamic params,
    bool tips = false,
  }) async {
    return _request(
      url,
      method: 'POST',
      params: params,
      tips: tips,
    );
  }

  // UPLOAD
  Future<BaseResponse> upload(
    String url, {
    dynamic params,
    bool tips = false,
    void Function(int, int)? onSendProgress,
    void Function(int, int)? onReceiveProgress,
  }) async {
    return _request(
      url,
      method: 'UPLOAD',
      params: params,
      tips: tips,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );
  }
}
