import 'package:brandstores/src/app/pages/member/products/member_products_presenter.dart';
import 'package:brandstores/src/domain/entities/member_center/member_products/member_products.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:brandstores/src/data/repositories/data_member_products_repository.dart';

class MemberProductsController extends Controller {
  MemberProductsController(
      DataMemberProductsRepository dataMemberProductsRepository)
      : presenter = MemberProductsPresenter(dataMemberProductsRepository);

  final MemberProductsPresenter presenter;

  MemberProducts? _historyProducts;
  MemberProducts? get historyProducts => _historyProducts;

  MemberProducts? _favoriteProducts;
  MemberProducts? get favoriteProducts => _favoriteProducts;

  MemberProducts? _boughtProducts;
  MemberProducts? get boughtProducts => _boughtProducts;

  @override
  void onInitState() {
    getHistoryProducts();
    getFavoriteProducts();
    getBoughtProducts();
  }

  @override
  void initListeners() {
    presenter.getMemberHistoryProductsOnNext = (MemberProducts products) {
      _historyProducts = products;

      /// The 'Controller' has access to the 'ViewState' and can refresh
      /// the 'ControllerWidgets' via 'refreshUI()'.
      refreshUI();
    };

    presenter.getMemberHistoryProductsOnComplete = () {
      debugPrint('History products retrieved.');
    };

    presenter.getMemberHistoryProductsOnError = (e) {
      debugPrint('Could not retrieve history products');

      _historyProducts = null;

      refreshUI();
    };

    presenter.getMemberFavoriteProductsOnNext = (MemberProducts products) {
      _favoriteProducts = products;

      /// The 'Controller' has access to the 'ViewState' and can refresh
      /// the 'ControllerWidgets' via 'refreshUI()'.
      refreshUI();
    };

    presenter.getMemberFavoriteProductsOnComplete = () {
      debugPrint('Favorite products retrieved.');
    };

    presenter.getMemberFavoriteProductsOnError = (e) {
      debugPrint('Could not retrieve favorite products');

      _favoriteProducts = null;

      refreshUI();
    };

    presenter.getMemberBoughtProductsOnNext = (MemberProducts products) {
      _boughtProducts = products;

      /// The 'Controller' has access to the 'ViewState' and can refresh
      /// the 'ControllerWidgets' via 'refreshUI()'.
      refreshUI();
    };

    presenter.getMemberBoughtProductsOnComplete = () {
      debugPrint('Bought products retrieved.');
    };

    presenter.getMemberBoughtProductsOnError = (e) {
      debugPrint('Could not retrieve bought products');

      _boughtProducts = null;

      refreshUI();
    };
  }

  @override
  void onResumed() => debugPrint('On resumed');

  @override
  void onReassembled() => debugPrint('View is about to be ressembled');

  @override
  void onDeactivated() => debugPrint('View is about to be deactivated');

  @override
  void onDisposed() {
    // don't forget to dispose of the presenter
    presenter.dispose();
    super.onDisposed();
  }

  void getHistoryProducts() => presenter.getMemberHistoryProducts();

  void getFavoriteProducts() => presenter.getMemberFavoriteProducts();

  void getBoughtProducts() => presenter.getMemberBoughtProducts();
}
