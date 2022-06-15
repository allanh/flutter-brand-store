import 'package:brandstores/src/domain/usecases/member_center/get_member_products_usecase.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class MemberProductsPresenter extends Presenter {
  late Function getMemberBrowseProductsOnNext;
  late Function getMemberBrowseProductsOnComplete;
  late Function getMemberBrowseProductsOnError;

  late Function getMemberFavoriteProductsOnNext;
  late Function getMemberFavoriteProductsOnComplete;
  late Function getMemberFavoriteProductsOnError;

  late Function getMemberBoughtProductsOnNext;
  late Function getMemberBoughtProductsOnComplete;
  late Function getMemberBoughtProductsOnError;

  final GetMemberBrowseProductsUseCase getMemberBrowseProductsUseCase;
  final GetMemberFavoriteProductsUseCase getMemberFavoriteProductsUseCase;
  final GetMemberBoughtProductsUseCase getMemberBoughtProductsUseCase;

  MemberProductsPresenter(memberProductsRepo)
      : getMemberBrowseProductsUseCase =
            GetMemberBrowseProductsUseCase(memberProductsRepo),
        getMemberFavoriteProductsUseCase =
            GetMemberFavoriteProductsUseCase(memberProductsRepo),
        getMemberBoughtProductsUseCase =
            GetMemberBoughtProductsUseCase(memberProductsRepo);

  void getMemberBrowseProducts(int page) {
    getMemberBrowseProductsUseCase.execute(
        _GetMemberBrowseProductsUseCaseObserver(this),
        GetMemberBrowseProductsUseCaseParams(page));
  }

  void getMemberFavoriteProducts(int page) {
    getMemberFavoriteProductsUseCase.execute(
        _GetMemberFavoriteProductsUseCaseObserver(this),
        GetMemberFavoriteProductsUseCaseParams(page));
  }

  void getMemberBoughtProducts(int page) {
    getMemberBoughtProductsUseCase.execute(
        _GetMemberBoughtProductsUseCaseObserver(this),
        GetMemberBoughtProductsUseCaseParams(page));
  }

  @override
  void dispose() {
    getMemberBrowseProductsUseCase.dispose();
    getMemberFavoriteProductsUseCase.dispose();
    getMemberBoughtProductsUseCase.dispose();
  }
}

class _GetMemberBrowseProductsUseCaseObserver
    extends Observer<GetMemberBrowseProductsUseCaseResponse> {
  final MemberProductsPresenter presenter;

  _GetMemberBrowseProductsUseCaseObserver(this.presenter);

  @override
  void onComplete() {
    presenter.getMemberBrowseProductsOnComplete();
  }

  @override
  void onError(e) {
    presenter.getMemberBrowseProductsOnError(e);
  }

  @override
  void onNext(response) {
    presenter.getMemberBrowseProductsOnNext(response?.products);
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
