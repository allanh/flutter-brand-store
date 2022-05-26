import 'dart:async';

import 'package:brandstores/src/domain/entities/enum/verify_method.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import '../../repositories/account_repository.dart';

class ResetPasswordUseCase extends UseCase<ResetPasswordResponse, ResetPasswordParams> {
  final AccountRepository repository;

  ResetPasswordUseCase(this.repository);

  @override
  Future<Stream<ResetPasswordResponse?>> buildUseCaseStream(ResetPasswordParams? params) async {
    final controller = StreamController<ResetPasswordResponse>();

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
            final response = await repository.resetPassword('', '', email, params.password);
            controller.add(ResetPasswordResponse(response.isSuccess, response.error?.message));
            controller.close();
          } catch (e) {
            controller.addError(e);
          }
        }
        break;

      case VerifyMethod.mobile:
        var mobile = params.mobile;
        var mobileCode = params.mobileCode;
        if (mobile == null || mobile.isEmpty) {
          controller.addError(Exception('mobile is must'));
        } else if (mobileCode == null || mobileCode.isEmpty) {
          controller.addError(Exception('mobileCode is must'));
        } else {
          try {
            final response =
                await repository.resetPassword(mobileCode, mobile, '', params.password);
            controller.add(ResetPasswordResponse(response.isSuccess, response.error?.message));
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

class ResetPasswordParams {
  final VerifyMethod verifyMethod;
  final String password;
  final String? mobileCode;
  final String? mobile;
  final String? email;

  ResetPasswordParams(this.verifyMethod, this.password, {this.mobileCode, this.mobile, this.email});
}

class ResetPasswordResponse {
  final bool isSuccess;
  final String? errorMessage;

  ResetPasswordResponse(this.isSuccess, this.errorMessage);
}
