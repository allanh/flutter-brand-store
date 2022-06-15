import 'package:brandstores/src/domain/usecases/member_center/get_member_products_usecase.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class MemberProductsPresenter extends Presenter {
  late Function getMemberHistoryProductsOnNext;
  late Function getMemberHistoryProductsOnComplete;
  late Function getMemberHistoryProductsOnError;

  late Function getMemberFavoriteProductsOnNext;
  late Function getMemberFavoriteProductsOnComplete;
  late Function getMemberFavoriteProductsOnError;

  late Function getMemberBoughtProductsOnNext;
  late Function getMemberBoughtProductsOnComplete;
  late Function getMemberBoughtProductsOnError;

  final GetMemberHistoryProductsUseCase getMemberHistoryProductsUseCase;
  final GetMemberFavoriteProductsUseCase getMemberFavoriteProductsUseCase;
  final GetMemberBoughtProductsUseCase getMemberBoughtProductsUseCase;

  MemberProductsPresenter(memberProductsRepo)
      : getMemberHistoryProductsUseCase =
            GetMemberHistoryProductsUseCase(memberProductsRepo),
        getMemberFavoriteProductsUseCase =
            GetMemberFavoriteProductsUseCase(memberProductsRepo),
        getMemberBoughtProductsUseCase =
            GetMemberBoughtProductsUseCase(memberProductsRepo);

  void getMemberHistoryProducts() {
    getMemberHistoryProductsUseCase.execute(
        _GetMemberHistoryProductsUseCaseObserver(this),
        GetMemberHistoryProductsUseCaseParams());
  }

  void getMemberFavoriteProducts() {
    getMemberFavoriteProductsUseCase.execute(
        _GetMemberFavoriteProductsUseCaseObserver(this),
        GetMemberFavoriteProductsUseCaseParams());
  }

  void getMemberBoughtProducts() {
    getMemberBoughtProductsUseCase.execute(
        _GetMemberBoughtProductsUseCaseObserver(this),
        GetMemberBoughtProductsUseCaseParams());
  }

  @override
  void dispose() {
    getMemberHistoryProductsUseCase.dispose();
    getMemberFavoriteProductsUseCase.dispose();
    getMemberBoughtProductsUseCase.dispose();
  }
}

class _GetMemberHistoryProductsUseCaseObserver
    extends Observer<GetMemberHistoryProductsUseCaseResponse> {
  final MemberProductsPresenter presenter;

  _GetMemberHistoryProductsUseCaseObserver(this.presenter);

  @override
  void onComplete() {
    presenter.getMemberHistoryProductsOnComplete();
  }

  @override
  void onError(e) {
    presenter.getMemberHistoryProductsOnError(e);
  }

  @override
  void onNext(response) {
    presenter.getMemberHistoryProductsOnNext(response?.products);
  }
}

class _GetMemberFavoriteProductsUseCaseObserver
    extends Observer<GetMemberFavoriteProductsUseCaseResponse> {
  final MemberProductsPresenter presenter;

  _GetMemberFavoriteProductsUseCaseObserver(this.presenter);

  @override
  void onComplete() {
    presenter.getMemberFavoriteProductsOnComplete();
  }

  @override
  void onError(e) {
    presenter.getMemberFavoriteProductsOnError(e);
  }

  @override
  void onNext(response) {
    presenter.getMemberFavoriteProductsOnNext(response?.products);
  }
}

class _GetMemberBoughtProductsUseCaseObserver
    extends Observer<GetMemberBoughtProductsUseCaseResponse> {
  final MemberProductsPresenter presenter;

  _GetMemberBoughtProductsUseCaseObserver(this.presenter);

  @override
  void onComplete() {
    presenter.getMemberBoughtProductsOnComplete();
  }

  @override
  void onError(e) {
    presenter.getMemberBoughtProductsOnError(e);
  }

  @override
  void onNext(response) {
    presenter.getMemberBoughtProductsOnNext(response?.products);
  }
}
