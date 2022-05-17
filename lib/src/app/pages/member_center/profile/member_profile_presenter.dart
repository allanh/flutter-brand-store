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
