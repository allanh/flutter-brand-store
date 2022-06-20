import 'package:brandstores/src/app/utils/constants.dart';
import 'package:brandstores/src/domain/entities/enum/verify_type.dart';
import 'package:brandstores/src/domain/usecases/account/register_usecase.dart';
import 'package:brandstores/src/extension/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:go_router/go_router.dart';

import '../../../../domain/usecases/account/check_account_is_exist_usecase.dart';
import 'register_presenter.dart';

class RegisterController extends Controller {
  final RegisterPresenter presenter;

  int tabIndex = 0;

  String name = '';
  String email = '';
  String mobile = '';
  String password = '';
  String passwordConfirm = '';

  String? gender;
  DateTime? birthday;
  String? zip;
  String? city;
  String? area;
  String? address;

  String? emailError;
  String? mobileError;
  String? nameError;
  String? passwordError;
  String? passwordConfirmError;
  String? addressError;

  bool isEnableButton = false;

  RegisterController(repo)
      : presenter = RegisterPresenter(repo),
        super();

  void switchTab(int tabIndex) {
    this.tabIndex = tabIndex;
    checkMobile();
    checkEmail();
    isEnableSubmitButton();
  }

  void checkMobile() {
    if (mobile.isNotEmpty && !mobile.isValidMobile()) {
      mobileError = "請輸入有效手機號碼";
    }
  }

  void checkEmail() {
    if (email.isNotEmpty && !email.isValidEmail()) {
      emailError = "請輸入有效Email";
    }
  }

  void checkName() {
    if (name.isNotEmpty && !name.isValidName()) {
      nameError = "請輸入有效姓名";
    }
  }

  void checkPassword() {
    if (password.isNotEmpty && !password.isValidPwd()) {
      emailError = "請輸入6-20碼英數字";
    }
  }

  void checkPasswordConfirm() {
    if (passwordConfirm.isNotEmpty && passwordConfirm != password) {
      emailError = "密碼不一致";
    }
  }

  void isEnableSubmitButton() {
    var isEnable = true;
    switch (tabIndex) {
      case 0:
        if (mobile.isValidMobile()) {
          mobileError = null;
        } else {
          isEnable = false;
        }
        break;
      case 1:
        if (email.isValidEmail()) {
          emailError = null;
        } else {
          isEnable = false;
        }
        break;
    }

    if (password.isValidPwd()) {
      passwordError = null;
    } else {
      isEnable = false;
    }

    if (password == passwordConfirm) {
      passwordConfirmError = null;
    } else {
      isEnable = false;
    }

    if (name.isValidName()) {
      nameError = null;
    } else {
      isEnable = false;
    }

    isEnableButton = isEnable;
    debugPrint('isEnableButton: $isEnableButton,'
        ' tabIndex: $tabIndex,'
        ' mobile: ${mobile.isValidMobile()},'
        ' email: ${email.isValidEmail()},'
        ' name: ${name.isValidName()},'
        ' password: ${password.isValidPwd()},'
        ' passwordConfirm: ${password == passwordConfirm}');
  }

  void onEmailChange(String value) {
    email = value;
    isEnableSubmitButton();
  }

  void onMobileChange(String value) {
    mobile = value;
    isEnableSubmitButton();
  }

  void onPasswordChange(String value) {
    password = value;
    isEnableSubmitButton();
  }

  void onPasswordConfirmChange(String value) {
    passwordConfirm = value;
    isEnableSubmitButton();
  }

  void onNameChange(String value) {
    name = value;
    isEnableSubmitButton();
  }

  void onBirthdayChange(DateTime value) {
    birthday = value;
  }

  void onAddressChange(String? zip, String? city, String? area, String? address) {
    this.zip = zip;
    this.city = city;
    this.area = area;
    this.address = address;
  }

  @override
  void initListeners() {
    presenter.checkAccountOnNext = (CheckAccountIsExistResponse response) {
      if (response.isExist) {
        switch (tabIndex) {
          case 0:
            mobileError = '此手機已註冊，請重新輸入或直接登入';
            break;
          case 1:
            emailError = '此Email已註冊，請重新輸入或直接登入';
            break;
        }
        refreshUI();
      } else {
        _register();
      }
    };

    presenter.checkAccountOnError = (e) {
      debugPrint('onError: ${e.message}');
      refreshUI();
    };

    presenter.registerOnNext = (RegisterResponse response) {
      if (response.isSuccess) {
        _onSuccess();
      } else if (response.errorMessage?.isNotEmpty == true) {
        showApiResponseDialog(response.errorMessage ?? 'api response error');
        refreshUI();
      }
    };

    presenter.registerOnError = (e) {
      debugPrint('onError: $e');
      refreshUI();
    };
  }

  void checkAccountStatus() {
    if (tabIndex == 1) {
      presenter.checkEmailIsExist(email);
    } else {
      presenter.checkMobileIsExist('886', mobile);
    }
  }

  void _register() {
    if (tabIndex == 1) {
      presenter.emailRegister(name, email, password, gender, birthday, zip, city, area, address);
    } else {
      presenter.mobileRegister(name, '886', mobile, password, gender, birthday, zip, city, area, address);
    }
  }

  void _onSuccess() {
    if (tabIndex == 1) {
      // 註冊成功，請前網電子信用收取驗證信
    } else {
      getContext().pushNamed(verifyMobileCodeRouteName, queryParams: {
        "verifyType": VerifyType.addMember.value,
        "mobileCode": '886',
        "mobile": mobile,
      });
    }
  }

  Future<void> showApiResponseDialog(String message) {
    return showDialog<bool>(
      context: getContext(),
      builder: (context) => AlertDialog(
        content: Text(message),
        actions: <Widget>[
          TextButton(
            child: const Text("確認"),
            onPressed: () => Navigator.of(context).pop(),
          )
        ],
      ),
    );
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
