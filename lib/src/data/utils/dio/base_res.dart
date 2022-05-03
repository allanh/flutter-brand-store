import 'package:dio/dio.dart';

class BaseResponse {
  late String id;
  late String status;
  late String message;
  late dynamic data;
  late dynamic error;
  late bool isSuccess;
  Response? originalResponse;

  BaseResponse({
    required this.id,
    required this.status,
    required this.message,
    required this.data,
    required this.error,
    required this.isSuccess,
    required this.originalResponse,
  });

  BaseResponse.fromJson(dynamic json) {
    id = json?['id'] ?? '';
    status = json?['status'] ?? '';
    message = json?['message'] ?? '';
    data = json?['data'];
    error = json?['error'];
    isSuccess = status == 'SUCCESS' ? true : false;
  }
}
