import 'package:dio/dio.dart';

class BaseResponse {
  late String id;
  late String status;
  late String message;
  late dynamic data;
  late Error? error;
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
    error = json?['error'] == null ? null : Error.fromJson(json?['error']);
    isSuccess = status == 'SUCCESS' ? true : false;
  }
}

class Error {
  Error({
    this.code,
    this.message,
    this.reason,
  });

  String? code;
  String? message;
  String? reason;

  factory Error.fromJson(Map<String, dynamic> json) => Error(
        code: json["code"],
        message: json["message"],
        reason: json["reason"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        "reason": reason,
      };
}
