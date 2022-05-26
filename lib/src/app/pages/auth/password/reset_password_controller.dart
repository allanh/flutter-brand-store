import 'package:brandstores/src/app/utils/constants.dart';
import 'package:brandstores/src/domain/entities/enum/verify_method.dart';
import 'package:brandstores/src/domain/usecases/account/reset_password_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import 'package:go_router/go_router.dart';
import 'reset_password_presenter.dart';

class ResetPasswordController extends Controller {
  final ResetPasswordPresenter presenter;

  String inputPassword = '';
  String inputPasswordConfirm = '';
  bool isEnableButton = false;
  String? errorMessage;

  ResetPasswordController(repo)
      : presenter = ResetPasswordPresenter(repo),
        super();

  void onPasswordChange(String password) {
    inputPassword = password;
    checkButtonStatus();
  }

  void onPasswordConfirmChange(String password) {
    inputPasswordConfirm = password;
    checkButtonStatus();
  }

  void checkButtonStatus() {
    isEnableButton = inputPassword.isNotEmpty && inputPassword == inputPasswordConfirm;
    if (isEnableButton || inputPasswordConfirm.isEmpty || inputPassword.isEmpty) {
      errorMessage = null;
    } else if (inputPassword != inputPasswordConfirm) {
      errorMessage = '密碼不一致';
    }
  }

  void modifyPassword(
      VerifyMethod verifyMethod, String? mobileCode, String? mobile, String? email) {
    if (verifyMethod == VerifyMethod.email) {
      presenter.resetEmailPassword(email ?? '', inputPassword);
    } else {
      presenter.resetMobilePassword(mobileCode ?? '', mobile ?? '', inputPassword);
    }
  }

  @override
  void initListeners() {
    presenter.onNext = (ResetPasswordResponse response) {
      if (response.isSuccess) {
        onSuccess();
      } else {
        errorMessage = response.errorMessage;
        refreshUI();
      }
    };

    presenter.onError = (e) {
      errorMessage = e.message;
      refreshUI();
    };
  }

  void onSuccess() {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      getContext().goNamed(loginRouteName);
    });
  }

  @override
  void onResumed() => debugPrint('On resumed');

  @override
  void onReassembled() => debugPrint('View is about to be reassembled');

  @override
  void onDeactivated() => debugPrint('View is about to be deactivated');

  @override
  void onDisposed() {
    presenter.dispose(); // don't forget to dispose of the presenter
    super.onDisposed();
  }
}
