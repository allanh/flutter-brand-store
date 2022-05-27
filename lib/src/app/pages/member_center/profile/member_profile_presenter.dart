import 'package:brandstores/src/domain/usecases/get_member_profile_usecase.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class MemberProfilePresenter extends Presenter {
  late Function getMemberProfileOnNext;
  late Function getMemberProfileOnComplete;
  late Function getMemberProfileOnError;

  late Function verifyMobileOnNext;
  late Function verifyMobileOnComplete;
  late Function verifyMobileOnError;

  late Function loadDistrictsOnNext;
  late Function loadDistrictsOnComplete;
  late Function loadDistrictsOnError;

  final GetMemberProfileUseCase getMemberProfileUseCase;
  final VerifyMobileUseCase verifyMobileUseCase;
  final LoadDistrictsUseCase loadDistrictsUseCase;

  MemberProfilePresenter(memberProfileRepo)
      : getMemberProfileUseCase = GetMemberProfileUseCase(memberProfileRepo),
        verifyMobileUseCase = VerifyMobileUseCase(memberProfileRepo),
        loadDistrictsUseCase = LoadDistrictsUseCase(memberProfileRepo);

  void getMemberProfile() {
    getMemberProfileUseCase.execute(_GetMemberProfileUseCaseObserver(this),
        GetMemberProfileUseCaseParams());
  }

  void verifyMobile(
    String countryCode,
    String mobile,
  ) {
    verifyMobileUseCase.execute(_VerifyMobileUseCaseObserver(this),
        VerifyMobileUseCaseParams(countryCode, mobile));
  }

  void loadDistricts() {
    loadDistrictsUseCase.execute(
        _LoadDistrictsUseCaseObserver(this), LoadDistrictsUseCaseParams());
  }

  @override
  void dispose() {
    getMemberProfileUseCase.dispose();
    verifyMobileUseCase.dispose();
    loadDistrictsUseCase.dispose();
  }
}

/// 取會員資料
class _GetMemberProfileUseCaseObserver
    extends Observer<GetMemberProfileUseCaseResponse> {
  final MemberProfilePresenter presenter;

  _GetMemberProfileUseCaseObserver(this.presenter);

  @override
  void onComplete() {
    presenter.getMemberProfileOnComplete();
  }

  @override
  void onError(e) {
    presenter.getMemberProfileOnError(e);
  }

  @override
  void onNext(response) {
    presenter.getMemberProfileOnNext(response?.memberProfile);
  }
}

/// 門號驗證
class _VerifyMobileUseCaseObserver
    extends Observer<VerifyMobileUseCaseResponse> {
  final MemberProfilePresenter presenter;

  _VerifyMobileUseCaseObserver(this.presenter);

  @override
  void onComplete() {
    presenter.verifyMobileOnComplete();
  }

  @override
  void onError(e) {
    presenter.verifyMobileOnError(e);
  }

  @override
  void onNext(response) {
    presenter.verifyMobileOnNext(response?.result);
  }
}

/// 下載郵遞區號
class _LoadDistrictsUseCaseObserver
    extends Observer<LoadDistrictsUseCaseResponse> {
  final MemberProfilePresenter presenter;

  _LoadDistrictsUseCaseObserver(this.presenter);

  @override
  void onComplete() {
    presenter.loadDistrictsOnComplete();
  }

  @override
  void onError(e) {
    presenter.loadDistrictsOnError(e);
  }

  @override
  void onNext(response) {
    presenter.loadDistrictsOnNext(response?.districts);
  }
}
