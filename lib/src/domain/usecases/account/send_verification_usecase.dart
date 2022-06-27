import 'dart:async';

import 'package:brandstores/src/domain/entities/enum/verify_method.dart';
import 'package:brandstores/src/domain/entities/enum/verify_type.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import '../../repositories/account_repository.dart';

class SendVerificationUseCase
    extends UseCase<SendVerificationResponse, SendVerificationParams> {
  final AccountRepository repository;

  SendVerificationUseCase(this.repository);

  @override
  Future<Stream<SendVerificationResponse?>> buildUseCaseStream(
      SendVerificationParams? params) async {
    final controller = StreamController<SendVerificationResponse>();

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
            final response = await repository.sendVerification(
                params.verifyType, '', '', email);
            controller.add(SendVerificationResponse(
                response.isSuccess, response.error?.message));
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
            final response = await repository.sendVerification(
                params.verifyType, mobileCode, mobile, '');
            controller.add(SendVerificationResponse(
                response.isSuccess, response.error?.message));
            controller.close();
          } catch (e) {
            controller.addError(e);
          }
        }
        break;
    }

    return controller.stream;
  }
}

class SendVerificationParams {
  final VerifyType verifyType;
  final VerifyMethod verifyMethod;
  final String? mobileCode;
  final String? mobile;
  final String? email;

  SendVerificationParams(this.verifyType, this.verifyMethod,
      {this.mobileCode, this.mobile, this.email});
}

class SendVerificationResponse {
  final bool isSuccess;
  final String? errorMessage;

  SendVerificationResponse(this.isSuccess, this.errorMessage);
}
