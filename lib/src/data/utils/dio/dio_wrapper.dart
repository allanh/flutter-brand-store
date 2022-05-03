import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';

import 'base_res.dart';

class DioWrapper {
  static BaseResponse errorWrapper(Object e) {
    return BaseResponse(
      id: '',
      status: '',
      message: e is DioError ? _dioErrorWrapper(e) : '未知錯誤',
      data: null,
      error: null,
      isSuccess: false,
      originalResponse: null,
    );
  }

  static String _dioErrorWrapper(DioError error) {
    switch (error.type) {
      case DioErrorType.connectTimeout:
        return '網路連線超時，請檢查網路設定';
      case DioErrorType.sendTimeout:
        return '網路連線超時，請檢查網路設定';
      case DioErrorType.receiveTimeout:
        return '伺服器異常，請稍後重試！';
      case DioErrorType.response:
        return '伺服器異常，請稍後重試！';
      case DioErrorType.cancel:
        return '請求已被取消，請重新請求';
      default:
        return '網路異常，請稍後重試！';
    }
  }

  static BaseResponse responseWrapper(Response response) {
    // 此处如果数据比较大，可以使用 compute 放在后台计算
    final res = jsonDecode(response.data);
    debugPrint('${response.statusCode} : $res');
    if (response.statusCode == 200) {
      final BaseResponse wrapres = BaseResponse.fromJson(res);
      wrapres.originalResponse = response;
      return wrapres;
    } else {
      var msg = res["error"] ?? '';
      debugPrint('msg = $msg');
      if (response.statusCode == 401) {
        msg = 'token失效';
      }
      return BaseResponse(
        id: "",
        status: "",
        message: msg,
        data: null,
        error: null,
        isSuccess: false,
        originalResponse: response,
      );
    }
  }
}
