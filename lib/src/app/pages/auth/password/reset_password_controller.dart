import 'package:brandstores/src/app/utils/constants.dart';
import 'package:brandstores/src/domain/entities/enum/verify_method.dart';
import 'package:brandstores/src/domain/usecases/account/reset_password_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import 'package:go_router/go_router.dart';
import 'reset_password_presenter.dart';

class ResetPasswordController extends Controller {
  final ResetPasswordPresenter presenter;
  final VerifyMethod verifyMethod;

  String oldPassword = '';
  String newPassword = '';
  String confirmPassword = '';
  String? errorMessage;
  String? oldPasswordError;

  ResetPasswordController(repo, this.verifyMethod)
      : presenter = ResetPasswordPresenter(repo),
        super();

  void onOldPasswordChange(String password) {
    oldPassword = password;
    oldPasswordError = null;
    checkButtonStatus();
  }

  void onPasswordChange(String password) {
    newPassword = password;
    checkButtonStatus();
  }

  void onPasswordConfirmChange(String password) {
    confirmPassword = password;
    checkButtonStatus();
  }

  void checkButtonStatus() {
    if (confirmPassword.isNotEmpty && newPassword.isNotEmpty && newPassword != confirmPassword) {
      errorMessage = '密碼不一致';
    } else {
      errorMessage = null;
    }
  }

  bool get isEnableButton {
    if (verifyMethod == VerifyMethod.password) {
      return oldPassword.isNotEmpty && newPassword.isNotEmpty && newPassword == confirmPassword;
    } else {
      return newPassword.isNotEmpty && newPassword == confirmPassword;
    }
  }

  void modifyPassword(String? mobileCode, String? mobile, String? email) {
    switch (verifyMethod) {
      case VerifyMethod.email:
        presenter.resetEmailPassword(email ?? '', newPassword);
        break;
      case VerifyMethod.mobile:
        presenter.resetMobilePassword(mobileCode ?? '', mobile ?? '', newPassword);
        break;
      case VerifyMethod.password:
        presenter.resetPassword(oldPassword, newPassword);
        break;
    }
  }

  @override
  void initListeners() {
    presenter.onNext = (ResetPasswordResponse response) {
      if (response.isSuccess) {
        onSuccess();
      } else {
        if (verifyMethod == VerifyMethod.password) {
          oldPasswordError = response.errorMessage;
        } else {
          errorMessage = response.errorMessage;
        }
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
      ScaffoldMessenger.of(getContext()).showSnackBar(const SnackBar(content: Text('密碼修改成功')));
      if (verifyMethod == VerifyMethod.password) {
        getContext().pop();
      } else {
        getContext().goNamed(loginRouteName);
      }
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
