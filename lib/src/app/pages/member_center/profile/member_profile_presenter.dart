import 'package:brandstores/src/domain/entities/member_profile/member_profile.dart';
import 'package:brandstores/src/domain/usecases/get_member_profile_usecase.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class MemberProfilePresenter extends Presenter {
  late Function getMemberProfileOnNext;
  late Function getMemberProfileOnComplete;
  late Function getMemberProfileOnError;

  final GetMemberProfileUseCase getMemberProfileUseCase;

  MemberProfilePresenter(memberProfileRepo)
      : getMemberProfileUseCase = GetMemberProfileUseCase(memberProfileRepo);

  void getMemberProfile() {
    getMemberProfileUseCase.execute(_GetMemberProfileUseCaseObserver(this),
        GetMemberProfileUseCaseParams());
  }

  @override
  void dispose() {
    getMemberProfileUseCase.dispose();
  }
}

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

class MemberVerificationPresenter extends Presenter {
  late Function getMemberVerificationOnNext;
  late Function getMemberVerificationOnComplete;
  late Function getMemberVerificationOnError;

  final GetMemberVerificationUseCase getMemberVerificationUseCase;

  MemberVerificationPresenter(memberVerificationRepo)
      : getMemberVerificationUseCase =
            GetMemberVerificationUseCase(memberVerificationRepo);

  void mobileVerification(
    String countryCode,
    String mobile,
  ) {
    getMemberVerificationUseCase.execute(
        _GetMemberVerificationUseCaseObserver(this),
        GetMemberVerificationUseCaseParams(countryCode, mobile));
  }

  @override
  void dispose() {
    getMemberVerificationUseCase.dispose();
  }
}

class _GetMemberVerificationUseCaseObserver
    extends Observer<GetMemberVerificationUseCaseResponse> {
  final MemberVerificationPresenter presenter;

  _GetMemberVerificationUseCaseObserver(this.presenter);

  @override
  void onComplete() {
    presenter.getMemberVerificationOnComplete();
  }

  @override
  void onError(e) {
    presenter.getMemberVerificationOnError(e);
  }

  @override
  void onNext(response) {
    presenter.getMemberVerificationOnNext(response?.memberVerification);
  }
}
