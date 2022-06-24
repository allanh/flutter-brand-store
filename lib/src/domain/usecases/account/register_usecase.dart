import 'dart:async';

import 'package:brandstores/src/domain/entities/enum/verify_method.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import '../../../data/utils/dio/base_res.dart';
import '../../repositories/account_repository.dart';

class RegisterUseCase extends UseCase<RegisterResponse, RegisterParams> {
  final AccountRepository repository;

  RegisterUseCase(this.repository);

  @override
  Future<Stream<RegisterResponse?>> buildUseCaseStream(RegisterParams? params) async {
    final controller = StreamController<RegisterResponse>();

    if (params == null) {
      controller.addError(Exception('params is must'));
      return controller.stream;
    }

    switch (params.verifyMethod) {
      case VerifyMethod.email:
        var email = params.email;
        if (email == null || email.isEmpty) {
          controller.addError(Exception('email is must'));
        } else {
          try {
            var response = await repository.registerEmail(
                name: params.name,
                email: email,
                pwd: params.pwd,
                gender: params.gender,
                birth: params.birth,
                zip: params.zip,
                cityNo: params.cityNo,
                areaNo: params.areaNo,
                address: params.address);
            controller.add(_getResponse(VerifyMethod.email, response));
            controller.close();
          } catch (e) {
            controller.addError(e);
          }
        }
        break;

      case VerifyMethod.mobile:
      default:
        var mobile = params.mobile;
        var mobileCode = params.mobileCode;
        if (mobile == null || mobile.isEmpty) {
          controller.addError(Exception('mobile is must'));
        } else if (mobileCode == null || mobileCode.isEmpty) {
          controller.addError(Exception('mobileCode is must'));
        } else {
          try {
            var response = await repository.registerMobile(
                name: params.name,
                mobile: mobile,
                mobileCode: mobileCode,
                pwd: params.pwd,
                gender: params.gender,
                birth: params.birth,
                zip: params.zip,
                cityNo: params.cityNo,
                areaNo: params.areaNo,
                address: params.address);
            controller.add(_getResponse(VerifyMethod.mobile, response));
            controller.close();
          } catch (e) {
            controller.addError(e);
          }
        }
        break;
    }

    return controller.stream;
  }

  RegisterResponse _getResponse(VerifyMethod verifyMethod, BaseResponse response) => RegisterResponse(
      isSuccess: response.isSuccess,
      verifyMethod: response.data?['verify_method'] == null
          ? verifyMethod
          : response.data?['verify_method'] == VerifyMethod.email.value
              ? VerifyMethod.email
              : VerifyMethod.mobile,
      verifyCode: response.data?['verify_code'],
      errorMessage: response.error?.message);
}

class RegisterParams {
  final VerifyMethod verifyMethod;
  String name;
  String? mobileCode;
  String? mobile;
  String? email;
  String pwd;
  String? gender;
  DateTime? birth;
  String? zip;
  String? cityNo;
  String? areaNo;
  String? address;

  RegisterParams(
    this.verifyMethod, {
    required this.name,
    this.mobileCode,
    this.mobile,
    this.email,
    required this.pwd,
    this.gender,
    this.birth,
    this.zip,
    this.cityNo,
    this.areaNo,
    this.address,
  });
}

class RegisterResponse {
  final bool isSuccess;
  final VerifyMethod verifyMethod;
  final String? verifyCode;
  final String? errorMessage;

  RegisterResponse({
    required this.isSuccess,
    required this.verifyMethod,
    this.verifyCode,
    this.errorMessage,
  });
}
