import 'dart:async';

import 'package:brandstores/src/domain/entities/enum/verify_method.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import '../../repositories/account_repository.dart';

class CheckAccountIsExistUseCase
    extends UseCase<CheckAccountIsExistResponse, CheckAccountIsExistParams> {
  final AccountRepository repository;

  CheckAccountIsExistUseCase(this.repository);

  @override
  Future<Stream<CheckAccountIsExistResponse?>> buildUseCaseStream(
      CheckAccountIsExistParams? params) async {
    final controller = StreamController<CheckAccountIsExistResponse>();

    if (params == null) {
      controller.addError(Exception('params is must'));
      return controller.stream;
    }

    final bool isExist;
    switch (params.verifyMethod) {
      case VerifyMethod.email:
        var email = params.email;
        if (email == null || email.isEmpty) {
          controller.addError(Exception('email is must'));
        } else {
          try {
            isExist = await repository.accountIsExist('', '', email);
            controller.add(CheckAccountIsExistResponse(isExist));
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
            isExist = await repository.accountIsExist(mobileCode, mobile, '');
            controller.add(CheckAccountIsExistResponse(isExist));
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

class CheckAccountIsExistParams {
  final VerifyMethod verifyMethod;
  final String? mobileCode;
  final String? mobile;
  final String? email;

  CheckAccountIsExistParams(this.verifyMethod,
      {this.mobileCode, this.mobile, this.email});
}

class CheckAccountIsExistResponse {
  final bool isExist;

  CheckAccountIsExistResponse(this.isExist);
}
