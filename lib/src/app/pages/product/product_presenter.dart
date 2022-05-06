import '../../../domain/usecases/product/get_product_usecase.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class ProductPresenter extends Presenter {
  late Function getProductOnNext;
  late Function getProductOnComplete;
  late Function getProductOnError;

  final GetProductUseCase getProductUseCase;
  ProductPresenter(productsRepo)
      : getProductUseCase = GetProductUseCase(productsRepo);

  void getProduct({required String goodsNo, int? productId}) {
    // execute getProductProductCase
    getProductUseCase.execute(_GetProductUseCaseObserver(this),
        GetProductUseCaseParams(goodsNo, productId));
  }

  @override
  void dispose() {
    getProductUseCase.dispose();
  }
}

class _GetProductUseCaseObserver extends Observer<GetProductUseCaseResponse> {
  final ProductPresenter presenter;
  _GetProductUseCaseObserver(this.presenter);
  @override
  void onComplete() {
    // assert(presenter.getProductOnComplete != null);
    presenter.getProductOnComplete();
  }

  @override
  void onError(e) {
    // assert(presenter.getProductOnError != null);
    presenter.getProductOnError(e);
  }

  @override
  void onNext(response) {
    // assert(presenter.getProductOnNext != null);
    presenter.getProductOnNext(response?.product);
  }
}
