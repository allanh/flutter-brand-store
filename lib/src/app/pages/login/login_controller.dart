import 'package:brandstores/src/domain/usecases/account/get_login_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import 'login_presenter.dart';

class LoginController extends Controller {
  final LoginPresenter presenter;

  bool showEmailError = false;
  bool showMobileError = false;

  String? apiErrorMessage;
  bool showApiError = false;
  bool isLoginSuccess = false;

  final mobileTextController = TextEditingController();
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  var _tabIndex = 0;
  bool isEnableLoginButton = false;

  bool passwordVisible = false;

  LoginController(repo)
      : presenter = LoginPresenter(repo),
        super();

  void switchPasswordIcon() {
    passwordVisible = !passwordVisible;
  }

  void switchTabIndex(int tabIndex) {
    _tabIndex = tabIndex;
    isEnableSubmitButton();
  }

  bool isValidMobile(String input) =>
      input.isNotEmpty &&
      input.length == 10 &&
      RegExp("^09\\d{8}\$").hasMatch(input);

  bool isValidEmail(String input) =>
      input.isNotEmpty &&
      RegExp("^[a-zA-Z0-9][\\w.-]*[a-zA-Z0-9]@[a-zA-Z0-9][\\w.-]*[a-zA-Z0-9]\\.[a-zA-Z][a-zA-Z.]*[a-zA-Z]\$")
          .hasMatch(input);

  bool isValidPwd(String input) =>
      input.isNotEmpty &&
      input.length >= 6 &&
      RegExp(".*[A-Za-z].*").hasMatch(input) &&
      RegExp(".*\\d.*").hasMatch(input);

  void checkMobile() {
    debugPrint('checkMobile');
    var mobile = mobileTextController.text;
    if (mobile.isNotEmpty && !isValidMobile(mobile)) {
      showMobileError = true;
      refreshUI();
    }
  }

  void checkEmail() {
    debugPrint('checkEmail');
    var email = emailTextController.text;
    if (email.isNotEmpty && !isValidEmail(email)) {
      showEmailError = true;
      refreshUI();
    }
  }

  void isEnableSubmitButton() {
    var isEnable = true;
    switch (_tabIndex) {
      case 0:
        if (isValidMobile(mobileTextController.text)) {
          showMobileError = false;
        } else {
          isEnable = false;
        }
        break;
      case 1:
        if (isValidEmail(emailTextController.text)) {
          showEmailError = false;
        } else {
          isEnable = false;
        }
        break;
    }

    if (isValidPwd(passwordTextController.text)) {
      showApiError = false;
    } else {
      isEnable = false;
    }

    isEnableLoginButton = isEnable;
  }

  @override
  void onInitState() {
    passwordVisible = false;
  }

  @override
  void initListeners() {
    mobileTextController.addListener(() {
      isEnableSubmitButton();
      refreshUI();
    });
    emailTextController.addListener(() {
      isEnableSubmitButton();
      refreshUI();
    });
    passwordTextController.addListener(() {
      isEnableSubmitButton();
      refreshUI();
    });

    presenter.onNext = (GetLoginUseCaseResponse caseResponse) {
      isLoginSuccess = caseResponse.isLoginSuccess;
      showApiError = caseResponse.isLoginSuccess != true;
      apiErrorMessage = caseResponse.errorMessage;
      refreshUI(); // Refreshes the UI manually
    };

    presenter.onComplete = () {
      debugPrint('onComplete');
    };

    presenter.onError = (e) {
      debugPrint('onError: ${e.message}');
      refreshUI();
    };
  }

  void login() {
    if (_tabIndex == 1) {
      presenter.doLogin(
          "", "", emailTextController.text, passwordTextController.text);
    } else {
      presenter.doLogin(
          "886", mobileTextController.text, "", passwordTextController.text);
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
    mobileTextController.dispose();
    emailTextController.dispose();
    passwordTextController.dispose();
    super.onDisposed();
  }
}
