import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:go_router/go_router.dart';
import './product_presenter.dart';
import '../../../domain/entities/product/product.dart';

class ProductController extends Controller {
  final String? _goodsNo;
  final int? _productId;
  Product? _product;
  Product? get product => _product; // data used by the View
  final ProductPresenter productPresenter;
  // Presenter should always be initialized this way
  ProductController(productsRepo, this._goodsNo, this._productId)
      : productPresenter = ProductPresenter(productsRepo),
        super();

  @override
  void onInitState() {
    if (_goodsNo != null) {
      // TODO: 商品解析JSON問題待解
      getProduct(goodsNo: _goodsNo!, productId: _productId);
    }
  }

  @override
  // this is called automatically by the parent class
  void initListeners() {
    productPresenter.getProductOnNext = (Product product) {
      debugPrint(product.toString());
      _product = product;
      refreshUI(); // Refreshes the UI manually
    };
    productPresenter.getProductOnComplete = () {
      debugPrint('Product retrieved');
    };

    // On error, show a snackbar, remove the Product, and refresh the UI
    productPresenter.getProductOnError = (e) {
      debugPrint('Could not retrieve Product.');
      ScaffoldMessenger.of(getContext())
          .showSnackBar(SnackBar(content: Text(e.message)));
      _product = null;
      refreshUI(); // Refreshes the UI manually
    };
  }

  void getProduct({required String goodsNo, int? productId}) =>
      productPresenter.getProduct(goodsNo: goodsNo, productId: productId);
  void getProductwithError() =>
      productPresenter.getProduct(goodsNo: 'M04009000020119', productId: 57544);

  @override
  void onResumed() => debugPrint('On resumed');

  @override
  void onReassembled() => debugPrint('View is about to be reassembled');

  @override
  void onDeactivated() => debugPrint('View is about to be deactivated');

  @override
  void onDisposed() {
    productPresenter.dispose(); // don't forget to dispose of the presenter
    super.onDisposed();
  }
}
