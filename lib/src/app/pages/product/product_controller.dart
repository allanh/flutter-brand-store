import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:go_router/go_router.dart';
import './product_presenter.dart';
import '../../../domain/entities/product/product.dart';

class ProductController extends Controller {
  final String? _goodsNo;
  final int? _productId;
  // 商品
  Product? _product;
  Product? get product => _product; // 商品

  // 已選的規格品
  Product? _selectedProduct;
  Product? get selectedProduct => _selectedProduct;

  // 已選的規格品
  List<AddToCartParams>? _selectedAddonProduct;
  List<AddToCartParams>? get selectedAddonProduct => _selectedAddonProduct;

  final ProductPresenter productPresenter;
  // Presenter should always be initialized this way
  ProductController(productsRepo, this._goodsNo, this._productId)
      : productPresenter = ProductPresenter(productsRepo),
        super();

  @override
  void onInitState() {
    if (_goodsNo != null) {
      getProduct(goodsNo: _goodsNo!, productId: _productId);
    }
  }

  @override
  // this is called automatically by the parent class
  void initListeners() {
    productPresenter.getProductOnNext = (Product product) {
      debugPrint(product.toString());
      _product = product;
      // TODO: 測試用
      _selectedProduct = product;
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

  /// 取得商品
  void getProduct({required String goodsNo, int? productId}) =>
      productPresenter.getProduct(goodsNo: goodsNo, productId: productId);

  /// 測試錯誤資料用
  void getProductwithError() =>
      productPresenter.getProduct(goodsNo: 'M04009000020119', productId: 57544);

  /// 倒數結束後重取資料
  void onCountDownEnd() {
    getProduct(goodsNo: _goodsNo!, productId: _productId);
  }

  /// 加購商品
  void selectdAddonProduct(
          {required String goodsNo, int? productId, required int qty}) =>
      productPresenter.getProduct(goodsNo: goodsNo, productId: productId);
}
