import 'package:brandstores/login_state.dart';
import 'package:brandstores/src/app/utils/constants.dart';
import 'package:brandstores/src/domain/usecases/account/get_login_usecase.dart';
import 'package:brandstores/src/extension/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'login_presenter.dart';

class LoginController extends Controller {
  final LoginPresenter presenter;

  int tabIndex = 0;
  bool isEnableButton = false;

  String inputEmail = '';
  String inputMobile = '';
  String inputPassword = '';

  String? emailError;
  String? mobileError;
  String? passwordError;

  LoginController(repo)
      : presenter = LoginPresenter(repo),
        super();

  void switchTab(int tabIndex) {
    this.tabIndex = tabIndex;
    isEnableSubmitButton();
  }

  void onEmailChange(String email) {
    inputEmail = email;
    isEnableSubmitButton();
  }

  void onMobileChange(String mobile) {
    inputMobile = mobile;
    isEnableSubmitButton();
  }

  void onPasswordChange(String password) {
    inputPassword = password;
    isEnableSubmitButton();
  }

  void checkMobile() {
    if (inputMobile.isNotEmpty && !inputMobile.isValidMobile()) {
      mobileError = '請輸入有效手機號碼';
    }
  }

  void checkEmail() {
    if (inputEmail.isNotEmpty && !inputEmail.isValidEmail()) {
      emailError = '請輸入有效Email';
    }
  }

  @override
  void initListeners() {
    presenter.onNext = (GetLoginUseCaseResponse response) {
      if (response.isLoginSuccess) {
        mobileError = null;
        emailError = null;
        passwordError = null;
        saveLoginState();
      } else {
        if (response.errorMessage?.contains("帳號") == true) {
          if (tabIndex == 1) {
            emailError = response.errorMessage;
          } else {
            mobileError = response.errorMessage;
          }
        } else {
          passwordError = response.errorMessage;
        }
        refreshUI();
      }
    };

    presenter.onComplete = () => debugPrint('onComplete');

    presenter.onError = (e) {
      debugPrint('onError: ${e.message}');
      passwordError = e.message;
      refreshUI();
    };
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

    if (inputPassword.isValidPwd()) {
      passwordError = null;
    } else {
      isEnable = false;
    }

    isEnableButton = isEnable;
  }

  void login() {
    if (tabIndex == 1) {
      presenter.doLogin("", "", inputEmail, inputPassword);
    } else {
      presenter.doLogin("886", inputMobile, "", inputPassword);
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

  void saveLoginState() {
    Provider.of<LoginState>(getContext(), listen: false).loggedIn = true;
    ScaffoldMessenger.of(getContext()).showSnackBar(const SnackBar(content: Text('登入成功')));
    closePage();
  }

  void closePage() {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      if (Navigator.canPop(getContext())) {
        Navigator.of(getContext()).pop();
      } else {
        getContext().goNamed(rootRouteName);
      }
    });
  }

  void forgotPassword() {
    getContext().pushNamed(forgetPasswordRouteName);
  }

  void register() {
    getContext().pushNamed(registerRouteName);
  }
}
