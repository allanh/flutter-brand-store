import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../storage/my_key.dart';
import '../storage/secure_storage.dart';
import 'api.dart';

class AuthInterceptor extends Interceptor {
  final _storage = SecureStorage();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (_needAuth(options.path)) {
      _storage.read(MyKey.auth).then((token) {
        if (token != null && token.isNotEmpty) {
          options.headers['authorization'] = token;
        }
      }).whenComplete(() => super.onRequest(options, handler));
    } else {
      super.onRequest(options, handler);
    }
  }

  bool _needAuth(String path) {
    switch (path) {
      case Api.memberData:
      case Api.memberCenter:
      case Api.setPassword:
      case Api.modules:
      case Api.getProduct:
      case Api.bougthProducts:
      case Api.historyProducts:
      case Api.favoriteProducts:
      case Api.invoiceSetting:
        return true;
      case Api.login:
      case Api.sendVerification:
      case Api.verifyMobileCode:
      case Api.resetPassword:
      case Api.accountCheck:
      case Api.register:
      case Api.exchangeBundle:
      case Api.thirdPartyLogin:
      case Api.thirdPartyAccountCheck:
      case Api.thirdPartyRegister:
      case Api.bundleMember:
      case Api.faq:
      case Api.bulletin:
      case Api.privacy:
      case Api.terms:
      case Api.about:
      case Api.siteSetting:
        return false;
    }
    return true;
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
    debugPrint('data: ${options.data}');
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
    debugPrint('---Request Error: ${err.toString()}');
    super.onError(err, handler);
  }
}
