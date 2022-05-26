import 'dart:async';

import 'package:brandstores/src/domain/entities/enum/verify_type.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import '../../repositories/account_repository.dart';

class VerifyMobileCodeUseCase
    extends UseCase<VerifyMobileCodeResponse, VerifyMobileCodeParams> {
  final AccountRepository repository;

  VerifyMobileCodeUseCase(this.repository);

  @override
  Future<Stream<VerifyMobileCodeResponse?>> buildUseCaseStream(
      VerifyMobileCodeParams? params) async {
    final controller = StreamController<VerifyMobileCodeResponse>();

    if (params == null) {
      controller.addError(Exception('params is must'));
      return controller.stream;
    }

    var mobile = params.mobile;
    var mobileCode = params.mobileCode;
    var verifyCode = params.verifyCode;
    if (mobile.isEmpty) {
      controller.addError(Exception('mobile is must'));
    } else if (mobileCode.isEmpty) {
      controller.addError(Exception('mobileCode is must'));
    } else if (verifyCode.isEmpty) {
      controller.addError(Exception('verifyCode is must'));
    } else {
      try {
        final response = await repository.verifyMobileCode(
            params.verifyType, mobileCode, mobile, params.verifyCode);
        controller.add(VerifyMobileCodeResponse(
            response.isSuccess, response.error?.message));
        controller.close();
      } catch (e) {
        controller.addError(e);
      }
    }
    return controller.stream;
  }
}

class VerifyMobileCodeParams {
  final VerifyType verifyType;
  final String mobileCode;
  final String mobile;
  final String verifyCode;

  VerifyMobileCodeParams(
      this.verifyType, this.mobileCode, this.mobile, this.verifyCode);
}

class VerifyMobileCodeResponse {
  final bool isSuccess;
  final String? errorMessage;

  VerifyMobileCodeResponse(this.isSuccess, this.errorMessage);
}
