import 'package:brandstores/src/app/utils/constants.dart';
import 'package:brandstores/src/domain/entities/enum/verify_type.dart';
import 'package:brandstores/src/domain/usecases/account/send_verification_usecase.dart';
import 'package:brandstores/src/extension/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:go_router/go_router.dart';

import 'forget_password_presenter.dart';

class ForgetPasswordController extends Controller {
  final ForgetPasswordPresenter presenter;

  String inputEmail = '';
  String inputMobile = '';

  int tabIndex = 0;

  String? emailError;
  String? mobileError;

  bool isEnableButton = false;

  ForgetPasswordController(repo)
      : presenter = ForgetPasswordPresenter(repo),
        super();

  void switchTab(int tabIndex) {
    this.tabIndex = tabIndex;
    checkMobile();
    checkEmail();
    isEnableSubmitButton();
  }

  void checkMobile() {
    if (inputMobile.isNotEmpty && !inputMobile.isValidMobile()) {
      mobileError = "請輸入有效手機號碼";
      refreshUI();
    }
  }

  void checkEmail() {
    if (inputEmail.isNotEmpty && !inputEmail.isValidEmail()) {
      emailError = "請輸入有效Email";
      refreshUI();
    }
  }

  void isEnableSubmitButton() {
    var isEnable = true;
    switch (tabIndex) {
      case 0:
        if (inputMobile.isValidMobile()) {
          mobileError = null;
        } else {
          isEnable = false;
        }
        break;
      case 1:
        if (inputEmail.isValidEmail()) {
          emailError = null;
        } else {
          isEnable = false;
        }
        break;
    }

    isEnableButton = isEnable;
  }

  void onEmailChange(String email) {
    inputEmail = email;
    isEnableSubmitButton();
    refreshUI();
  }

  void onMobileChange(String mobile) {
    inputMobile = mobile;
    isEnableSubmitButton();
    refreshUI();
  }

  @override
  void initListeners() {
    presenter.onNext = (SendVerificationResponse response) {
      if (response.isSuccess) {
        _onSuccess();
      } else {
        switch (tabIndex) {
          case 0:
            mobileError = response.errorMessage;
            break;
          case 1:
            emailError = response.errorMessage;
            break;
        }
        refreshUI();
      }
    };

    presenter.onError = (e) {
      debugPrint('onError: ${e.message}');
      refreshUI();
    };
  }

  void sendVerification() {
    if (tabIndex == 1) {
      presenter.sendEmailVerification(inputEmail);
    } else {
      presenter.sendMobileVerification("886", inputMobile);
    }
  }

  void _onSuccess() {
    if (tabIndex == 1) {
      // 請前往您的電子信箱收取重設密碼說明信，並依照步驟完成設定。
    } else {
      getContext().pushNamed(verifyMobileCodeRouteName, queryParams: {
        "verifyType": VerifyType.resetPassword.value,
        "mobileCode": '886',
        "mobile": inputMobile,
      });
    }
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
