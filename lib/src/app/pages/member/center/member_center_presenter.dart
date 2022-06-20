/// Every 'Controller' has-a 'Presenter'. The 'Presenter' communicates
/// with the 'Usecase' as mentioned at the beginning of the 'App' layer.
/// The 'Presenter' will have members that are functions, which are
/// optionally set by the 'Controller' and will be called if set uppon
/// the 'Usecase' sending back data, completing, or erroring.

import 'package:brandstores/src/domain/usecases/member/get_member_center_usecase.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

/// The 'Presenter' is comprised of two classes: 'Presenter' and 'Observer<T>'

/// 'Presenter'
/// - Contains the event-handlers set by the 'Controller'
/// - Contains the 'Usecase' to be used
/// - Initializes and executes the usecase with the 'Observer<T>'
///   class and the appropriate arguments.
class MemberCenterPresenter extends Presenter {
  late Function getMemberCenterOnNext;
  late Function getMemberCenterOnComplete;
  late Function getMemberCenterOnError;

  final GetMemberCenterUseCase getMemberCenterUseCase;
  MemberCenterPresenter(memberCenterRepo)
      : getMemberCenterUseCase = GetMemberCenterUseCase(memberCenterRepo);

  void getMemberCenter() {
    getMemberCenterUseCase.execute(
        _GetMemberCenterUseCaseObserver(this), GetMemberCenterUseCaseParams());
  }

  @override
  void dispose() {
    getMemberCenterUseCase.dispose();
  }
}

/// 'Observer<T>'
/// - Has reference to the 'Presenter' class. Ideally, this should
///   be an inner class but 'Dart' does not yet support them.
/// - Implements 3 functions
///   * onNext(T)
///   * onComplete()
///   * onError()
/// - These 3 methods represent all possible outputs of the 'Usecase'
///   * If the 'Usecase' returns an object, it will be passed to 'onNext(T)'.
///   * If it errors, it will call 'onError(e)'.
///   * Once it completes, it will call 'onComplete()'.
/// - These methods will then call the corresponding methods of the
///   'Presenter' that are set by the 'Controller'. This way, the event
///   is passed to the 'Controller', which can then manipulate data
///   and update the 'ViewState'.
class _GetMemberCenterUseCaseObserver
    extends Observer<GetMemberCenterUseCaseResponse> {
  final MemberCenterPresenter presenter;

  _GetMemberCenterUseCaseObserver(this.presenter);

  @override
  void onComplete() {
    presenter.getMemberCenterOnComplete();
  }

  @override
  void onError(e) {
    presenter.getMemberCenterOnError(e);
  }

  @override
  void onNext(response) {
    presenter.getMemberCenterOnNext(response?.memberCenter);
  }
}
