import 'package:brandstores/src/app/pages/member/products/member_products_presenter.dart';
import 'package:brandstores/src/domain/entities/member_center/member_products/member_products.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:brandstores/src/data/repositories/data_member_products_repository.dart';

class MemberProductsController extends Controller {
  MemberProductsController(
    DataMemberProductsRepository dataMemberProductsRepository,
    this.scrollController,
  ) : presenter = MemberProductsPresenter(dataMemberProductsRepository);

  final MemberProductsPresenter presenter;

  ScrollController scrollController = ScrollController();

  MemberProductsInfo? _browseProductsInfo;
  MemberProductsInfo? get browseProductsInfo => _browseProductsInfo;

  MemberProductsInfo? _favoriteProductsInfo;
  MemberProductsInfo? get favoriteProductsInfo => _favoriteProductsInfo;

  MemberProductsInfo? _boughtProductsInfo;
  MemberProductsInfo? get boughtProductsInfo => _boughtProductsInfo;

  @override
  void onInitState() {
    getBrowseProducts(1);
    getFavoriteProducts(1);
    getBoughtProducts(1);
  }

  @override
  void initListeners() {
    presenter.getMemberBrowseProductsOnNext =
        (MemberProductsInfo productsInfo) {
      if (_browseProductsInfo == null) {
        _browseProductsInfo = productsInfo;
      } else {
        _browseProductsInfo!.currentPage = productsInfo.currentPage;
        _browseProductsInfo!.products.insertAll(
            _browseProductsInfo!.products.length, productsInfo.products);
      }

      /// The 'Controller' has access to the 'ViewState' and can refresh
      /// the 'ControllerWidgets' via 'refreshUI()'.
      refreshUI();
    };

    presenter.getMemberBrowseProductsOnComplete = () {
      debugPrint('History products retrieved.');
    };

    presenter.getMemberBrowseProductsOnError = (e) {
      debugPrint('Could not retrieve history products');

      _browseProductsInfo = null;

      refreshUI();
    };

    presenter.getMemberFavoriteProductsOnNext =
        (MemberProductsInfo productsInfo) {
      if (_favoriteProductsInfo == null) {
        _favoriteProductsInfo = productsInfo;
      } else {
        _favoriteProductsInfo!.currentPage = productsInfo.currentPage;
        _favoriteProductsInfo!.products.insertAll(
            _favoriteProductsInfo!.products.length, productsInfo.products);
      }

      /// The 'Controller' has access to the 'ViewState' and can refresh
      /// the 'ControllerWidgets' via 'refreshUI()'.
      refreshUI();
    };

    presenter.getMemberFavoriteProductsOnComplete = () {
      debugPrint('Favorite products retrieved.');
    };

    presenter.getMemberFavoriteProductsOnError = (e) {
      debugPrint('Could not retrieve favorite products');

      _favoriteProductsInfo = null;

      refreshUI();
    };

    presenter.getMemberBoughtProductsOnNext =
        (MemberProductsInfo productsInfo) {
      if (_boughtProductsInfo == null) {
        _boughtProductsInfo = productsInfo;
      } else {
        _boughtProductsInfo!.currentPage = productsInfo.currentPage;
        _boughtProductsInfo!.products.insertAll(
            _boughtProductsInfo!.products.length, productsInfo.products);
      }

      /// The 'Controller' has access to the 'ViewState' and can refresh
      /// the 'ControllerWidgets' via 'refreshUI()'.
      refreshUI();
    };

    presenter.getMemberBoughtProductsOnComplete = () {
      debugPrint('Bought products retrieved.');
    };

    presenter.getMemberBoughtProductsOnError = (e) {
      debugPrint('Could not retrieve bought products');

      _boughtProductsInfo = null;

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
    scrollController.dispose();
    super.onDisposed();
  }

  void getBrowseProducts(int page) => presenter.getMemberBrowseProducts(page);

  void getFavoriteProducts(int page) =>
      presenter.getMemberFavoriteProducts(page);

  void getBoughtProducts(int page) => presenter.getMemberBoughtProducts(page);

  bool hasNextBrowseProductsPage() {
    final totalPage = _browseProductsInfo?.totalPage ?? 0;
    final currentPage = _browseProductsInfo?.currentPage ?? 0;
    return currentPage < totalPage;
  }

  bool hasNextFavoriteProductsPage() {
    final totalPage = _favoriteProductsInfo?.totalPage ?? 0;
    final currentPage = _favoriteProductsInfo?.currentPage ?? 0;
    return currentPage < totalPage;
  }

  bool hasNextBoughtProductsPage() {
    final totalPage = _boughtProductsInfo?.totalPage ?? 0;
    final currentPage = _boughtProductsInfo?.currentPage ?? 0;
    return currentPage < totalPage;
  }
}
