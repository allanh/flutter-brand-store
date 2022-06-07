import 'package:brandstores/src/app/utils/constants.dart';
import 'package:brandstores/src/domain/entities/enum/verify_type.dart';
import 'package:brandstores/src/domain/usecases/account/verify_mobile_code_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:go_router/go_router.dart';

import 'otp_presenter.dart';

class OtpController extends Controller {
  final OtpPresenter presenter;

  String inputMobile = '';
  String inputMobileCode = '';
  String inputOtp = '';
  String? apiErrorMessage;

  OtpController(repo)
      : presenter = OtpPresenter(repo),
        super();

  @override
  void initListeners() {
    presenter.onNext = (VerifyMobileCodeResponse response) {
      if (response.isSuccess) {
        apiErrorMessage = null;
        getContext().pushNamed(resetPasswordRouteName, queryParams: {
          "mobileCode": inputMobileCode,
          "mobile": inputMobile,
        });
      } else {
        apiErrorMessage = response.errorMessage;
      }
      refreshUI();
    };

    presenter.onError = (e) {
      apiErrorMessage = e.message;
      refreshUI();
    };
  }

  void verifyOtp(VerifyType verifyType, String mobileCode, String mobile) {
    inputMobileCode = mobileCode;
    inputMobile = mobile;
    presenter.verifyMobileCode(verifyType, mobileCode, mobile, inputOtp);
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
