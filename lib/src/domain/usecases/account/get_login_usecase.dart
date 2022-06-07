import 'dart:async';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import '../../repositories/account_repository.dart';

class GetLoginUseCase
    extends UseCase<GetLoginUseCaseResponse, GetLoginUseCaseParams> {
  final AccountRepository accountRepository;

  GetLoginUseCase(this.accountRepository);

  @override
  Future<Stream<GetLoginUseCaseResponse?>> buildUseCaseStream(
      GetLoginUseCaseParams? params) async {
    final controller = StreamController<GetLoginUseCaseResponse>();

    var mobileCode = params?.mobileCode;
    var mobile = params?.mobile;
    var email = params?.email;
    var pwd = params?.pwd;

    if (pwd == null || pwd.isEmpty) {
      controller.addError(Exception('password is must'));
    } else {
      try {
        final data = await accountRepository.login(
            mobileCode ?? '', mobile ?? '', email ?? '', pwd);
        controller.add(GetLoginUseCaseResponse(data.isSuccess, data.error?.message));
        controller.close();
      } catch (e) {
        controller.addError(e);
      }
    }
    return controller.stream;
  }
}

class GetLoginUseCaseParams {
  final String mobileCode;
  final String mobile;
  final String email;
  final String pwd;

  GetLoginUseCaseParams(this.mobileCode, this.mobile, this.email, this.pwd);
}

class GetLoginUseCaseResponse {
  final bool isLoginSuccess;
  final String? errorMessage;

  GetLoginUseCaseResponse(this.isLoginSuccess, this.errorMessage);
}
