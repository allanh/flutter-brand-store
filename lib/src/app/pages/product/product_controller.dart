import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:go_router/go_router.dart';
import '../../../domain/entities/link.dart';
import '../../utils/constants.dart';
import './product_presenter.dart';
import '../../../domain/entities/product/product.dart';

class ProductController extends Controller {
  // 商品編號
  final String? _goodsNo;
  // 規格品編號
  final int? _productId;
  // 商品資料
  Product? _product;
  Product? get product => _product; // 商品

  // 已選的規格品
  AddToCartParams? _selectedSpecParams;
  AddToCartParams? get selectedSpecParams => _selectedSpecParams;

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
      // 建立可加入購物車的規格參數
      _selectedSpecParams = product.getAddToCartParams(_productId);
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
  void addAddonProduct(
      {required String goodsNo, int? productId, required int qty}) {
    //_selectedAddons?.where((element) => element.no == goodsNo);
  }

  /// 刪除加購商品
  void removeAddonProduct(
      {required String goodsNo, int? productId, required int qty}) {
    // _selectedAddons?.removeWhere((element) => element.no == goodsNo);
  }

  // 點擊連結
  void onTap(Link? link) {
    if (link != null) {
      switch (link.type) {
        case LinkType.product:
          getContext().goNamed(productRouteName,
              params: {QueryKey.goodsNo: link.value});
          break;
        default:
          debugPrint('default link');
      }
    } else {
      debugPrint('no link');
    }
  }

  // 點擊圖片
  void handleImageTapped(int index) {
    getContext().pushNamed(productImageRouteName, params: {
      QueryKey.goodsNo: _product?.no ?? '',
      QueryKey.index: index.toString(),
    }, extra: <String, Object>{
      QueryKey.imagePaths:
          _product?.imageList?.map((e) => e.url!).toList() ?? []
    });
  }

  // 開啟規格頁
  void openSpecPage() => getContext().pushNamed(specName, params: {
        QueryKey.goodsNo: _product?.no ?? ''
      }, extra: {
        QueryKey.productController: this,
      });

  // 選擇規格
  void handleSpecChoosed(AddToCartParams params) {
    _selectedSpecParams = params;
  }

  // 加入收藏
  void handlefavoriteTapped() {
    getContext().pop();
  }

  // 加入購物車
  void handleAddToCartTapped() {
    getContext().pop();
  }

  // 立即購買
  void handleBuyNowTapped() {
    getContext().pop();
  }
}
