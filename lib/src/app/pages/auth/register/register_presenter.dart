import 'package:brandstores/src/domain/entities/enum/verify_method.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import '../../../../domain/usecases/account/check_account_is_exist_usecase.dart';
import '../../../../domain/usecases/account/register_usecase.dart';

class RegisterPresenter extends Presenter {
  late Function checkAccountOnNext;
  late Function checkAccountOnError;
  late Function registerOnNext;
  late Function registerOnError;

  late final CheckAccountIsExistUseCase _checkAccountUseCase;
  late final RegisterUseCase _registerUseCase;

  RegisterPresenter(repo) {
    _checkAccountUseCase = CheckAccountIsExistUseCase(repo);
    _registerUseCase = RegisterUseCase(repo);
  }

  @override
  void dispose() {
    _checkAccountUseCase.dispose();
    _registerUseCase.dispose();
  }

  void checkEmailIsExist(String email) {
    _checkAccountUseCase.execute(
        _CheckAccountObserver(this), CheckAccountIsExistParams(VerifyMethod.email, email: email));
  }

  void checkMobileIsExist(String mobileCode, String mobile) {
    _checkAccountUseCase.execute(_CheckAccountObserver(this),
        CheckAccountIsExistParams(VerifyMethod.mobile, mobileCode: mobileCode, mobile: mobile));
  }

  void emailRegister(
    String name,
    String email,
    String pwd,
    String? gender,
    DateTime? birth,
    String? zip,
    String? cityNo,
    String? areaNo,
    String? address,
  ) {
    _registerUseCase.execute(
        _RegisterObserver(this),
        RegisterParams(VerifyMethod.email,
            name: name,
            email: email,
            pwd: pwd,
            gender: gender,
            birth: birth,
            zip: zip,
            cityNo: cityNo,
            areaNo: areaNo,
            address: address));
  }

  void mobileRegister(
      String name,
      String mobileCode,
      String mobile,
      String pwd,
      String? gender,
      DateTime? birth,
      String? zip,
      String? cityNo,
      String? areaNo,
      String? address,
      ) {
    _registerUseCase.execute(
        _RegisterObserver(this),
        RegisterParams(VerifyMethod.mobile,
            name: name,
            mobileCode: mobileCode,
            mobile: mobile,
            pwd: pwd,
            gender: gender,
            birth: birth,
            zip: zip,
            cityNo: cityNo,
            areaNo: areaNo,
            address: address));
  }
}

class _CheckAccountObserver extends Observer<CheckAccountIsExistResponse> {
  final RegisterPresenter presenter;

  _CheckAccountObserver(this.presenter);

  @override
  void onComplete() {}

  @override
  void onError(e) => presenter.checkAccountOnError(e);

  @override
  void onNext(response) => presenter.checkAccountOnNext(response);
}

class _RegisterObserver extends Observer<RegisterResponse> {
  final RegisterPresenter presenter;

  _RegisterObserver(this.presenter);

  @override
  void onComplete() {}

  @override
  void onError(e) => presenter.registerOnError(e);

  @override
  void onNext(response) => presenter.registerOnNext(response);
}
