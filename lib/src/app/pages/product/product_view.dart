import 'package:brandstores/src/app/utils/constants.dart';
import 'package:brandstores/src/app/utils/screen_config.dart';
import 'package:brandstores/src/app/widgets/product/event_countdown_row_widget.dart';
import 'package:brandstores/src/app/widgets/product/product_addon_row_widget.dart';
import 'package:brandstores/src/app/widgets/product/product_app_bar.dart';
import 'package:brandstores/src/app/widgets/product/product_recommend_widget.dart';
import 'package:brandstores/src/device/utils/my_plus_colors.dart';
import 'package:brandstores/src/domain/entities/product/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:go_router/go_router.dart';
import '../../widgets/product/base_product_row_widget.dart';
import '../../widgets/product/full_image/image_slider_widget.dart';
import '../../widgets/product/product_bottom_bar_widget.dart';
import '../../widgets/product/product_category_row_widget.dart';
import '../../widgets/product/product_divider_widget.dart';
import '../../widgets/product/product_event_row_widget.dart';
import '../../widgets/product/product_freebie_row_widget.dart';
import '../../widgets/product/product_introduction_widget.dart';
import '../../widgets/product/product_name_widget.dart';
import '../../widgets/product/product_payment_row_widget.dart';
import '../../widgets/product/product_shipped_widget.dart';
import '../../widgets/product/product_spec_row_widget.dart';
import '../../widgets/product/product_tags_row_widget.dart';
import '../../widgets/product/promotion_price_row_widget.dart';
import '../../widgets/product/promotion_tag_row_widget.dart';
import '../../widgets/product/product_recommend_widget.dart';
import './product_controller.dart';
import '../../../data/repositories/data_product_repository.dart';

class ProductPage extends View {
  final String? goodsNo;
  final int? productId;

  ProductPage({Key? key, this.goodsNo, this.productId}) : super(key: key);

  @override
  _ProductPageState createState() =>
      // inject dependencies inwards
      _ProductPageState(goodsNo, productId);
}

class _ProductPageState extends ViewState<ProductPage, ProductController> {
  _ProductPageState(goodsNo, productId)
      : super(ProductController(DataProductRepository(), goodsNo, productId));
  final CarouselController carouselController = CarouselController();
  double get ratio => SizeConfig.screenRatio;

  // ScrollController
  final ScrollController _scrollController =
      ScrollController(); // set controller on scrolling
  bool _isScrollingDown = false;
  bool _showTabBar = false; //this is to show tab bar

  // TabBar
  final _tabs = ['商品', '介紹', '推薦'];
  final introductionKey = GlobalKey();
  final recommendKey = GlobalKey();

  @override
  Widget get view {
    return ControlledWidgetBuilder<ProductController>(
        builder: (context, controller) {
      return Scaffold(key: globalKey, body: _body(controller));
    });
  }

  @override
  void initState() {
    super.initState();
    _initScrollListener();
  }

  /// 是否顯示 tabbar
  void _showTabbar(bool isShow) {
    setState(() {
      _showTabBar = isShow;
    });
  }

  // 增加監聽器
  void _initScrollListener() async {
    _scrollController.addListener(() {
      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        if (!_isScrollingDown) {
          _isScrollingDown = true;
          _showTabbar(true);
        }
      }
      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        if (_isScrollingDown) {
          _isScrollingDown = false;
          _showTabbar(false);
        }
      }
    });
  }

  Widget _body(ProductController controller) {
    return ControlledWidgetBuilder<ProductController>(
        builder: (context, controller) {
      return LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        return DefaultTabController(
            length: _tabs.length, // This is the number of tabs.
            child: Scaffold(
              extendBodyBehindAppBar: true,
              // AppBar
              appBar: ProductAppBarWidget(
                controller: controller,
                showTabBar: _showTabBar,
                tabs: _tabs,
                onTabBarTap: (int index) {
                  switch (index) {
                    case 0: // 捲動到最上面
                      _scrollController.jumpTo(30);
                      break;
                    case 1: // 捲動到商品介紹
                      if (introductionKey.currentContext != null) {
                        Scrollable.ensureVisible(
                            introductionKey.currentContext!);
                      }
                      break;
                    case 2: // 捲動到推薦商品
                      if (recommendKey.currentContext != null) {
                        Scrollable.ensureVisible(recommendKey.currentContext!);
                      }
                      break;
                  }
                },
              ),
              body: (controller.product != null)
                  ? Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        // 商品主頁內容
                        _buildBody(controller, controller.product!),

                        // 底部按鈕列
                        ProductBottomBarWidget(
                          product: controller.product!,
                          favoriteTapped: () =>
                              controller.handlefavoriteTapped(),
                          addToCartTapped: () =>
                              controller.handleAddToCartTapped(),
                          buyNowTapped: () => controller.handleBuyNowTapped(),
                        ),
                      ],
                    )
                  : _error,
            ));
      });
    });
  }

  /// 商品內容
  Widget _buildBody(ProductController controller, Product product) => Container(
      width: MediaQuery.of(context).size.width,
      color: UdiColors.white2,
      padding: EdgeInsets.only(
          top: SizeConfig.statusBarHeight + kToolbarHeight,
          bottom: 50 * SizeConfig.screenRatio),
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
          return SingleChildScrollView(
            controller: _scrollController,
            child: ConstrainedBox(
              constraints:
                  BoxConstraints(minHeight: viewportConstraints.maxHeight),
              child: Column(
                children: [
                  // 圖片或影片
                  AspectRatio(
                    aspectRatio: 1.0,
                    child: Stack(children: [
                      ImageSliderWidget(
                        imageList: product.mediaList ?? [],
                        imageTapped: (index) {
                          controller.handleImageTapped(index);
                        },
                      ),
                      // 圖標
                      if (product.productInfo?.isNotEmpty == true)
                        PromotionTagsWidget(product: product),
                    ]),
                  ),

                  // 倒數計時
                  if (product.countdownDuration != null)
                    EventCountDownRowWidget(
                      duration: product.countdownDuration!,
                      type: (product.status == ProductStatus.comingSoon)
                          ? EventCountDownType.comingSoon
                          : EventCountDownType.flashSale,
                      slogan: product.promotionApp?.slogan,
                      onTimerEned: () => controller.onCountDownEnd(),
                    ),

                  // 商品名稱
                  ProductNameWidget(product: controller.product),

                  // 促銷活動
                  if (product.eventList?.isNotEmpty == true)
                    BaseProductRowWidget(
                        title: '活　動',
                        marginTop: 8,
                        view: ProductEventsRowWidget(
                          //eventList: product.mockEvents,
                          eventList: product.eventList!,
                        ),
                        moreTapped: () => debugPrint('tap event')),

                  // 獨享價
                  if ((product.product?.promotionPriceAppDiff ?? 0) > 0)
                    BaseProductRowWidget(
                        title: '獨享價',
                        marginTop: 8,
                        view: PromotionPriceRowWidget(
                          promotionPrice:
                              product.product!.promotionPriceAppDiff!,
                        )),

                  // 規格
                  if (product.product != null)
                    BaseProductRowWidget(
                        title: '規　格',
                        marginTop: 8,
                        view: ProductSpecRowWidget(
                          product: product,
                          params: controller.selectedSpecParams,
                        ),
                        moreTapped: () => controller.openSpecPage()),

                  // 加購品
                  if (product.addonInfo?.isNotEmpty == true)
                    BaseProductRowWidget(
                        title: '加價購',
                        marginTop: 8,
                        view: ProductAddonRowWidget(
                          addons: product.addonInfo!,
                          //addons: product.mockAddons,
                          selectedAddons: [],
                        ),
                        moreTapped: () => debugPrint('tap addon')),

                  // 買就送
                  if (product.freebieInfo?.isNotEmpty == true)
                    BaseProductRowWidget(
                        title: '買就送',
                        marginTop: 8,
                        view: ProductFreeBieRowWidget(
                          freeBies: product.freebieInfo!,
                        ),
                        moreTapped: () => debugPrint('tap freebie')),

                  // 付款和運送方式
                  Container(
                      margin: const EdgeInsets.only(top: 8),
                      color: Colors.white,
                      child: Column(
                        children: [
                          if (product.paymentInfo != null &&
                              product.productInfo!.first.proposedPrice != null)
                            BaseProductRowWidget(
                                title: '付　款',
                                view: ProductPaymentRowWidget(
                                  price:
                                      product.productInfo!.first.proposedPrice!,
                                  info: product.paymentInfo!,
                                ),
                                moreTapped: () => debugPrint('tap payment')),
                          const ProductDividerWidget(),
                          if (product.shippedMethod?.isNotEmpty == true)
                            BaseProductRowWidget(
                              title: '運　送',
                              view: ProductShippedWidget(
                                methods: product.shippedMethod!,
                              ),
                            ),
                        ],
                      )),

                  // 商品資訊
                  Container(
                      margin: const EdgeInsets.only(top: 8),
                      color: Colors.white,
                      child: Column(
                        children: [
                          // 編號
                          BaseProductRowWidget(
                              title: '編　號',
                              view: Text(product.no!,
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption
                                      ?.copyWith(
                                          fontSize: 14.0,
                                          color: UdiColors.greyishBrown))),

                          // 品牌
                          const ProductDividerWidget(),
                          if (product.brandName != null)
                            BaseProductRowWidget(
                              title: '品　牌',
                              view: Text(product.brandName!,
                                  textAlign: TextAlign.left,
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption
                                      ?.copyWith(
                                          fontSize: 14.0,
                                          color: Theme.of(context).primaryColor,
                                          decoration:
                                              TextDecoration.underline)),
                            ),

                          // 標籤
                          if (product.tags?.isNotEmpty == true)
                            const ProductDividerWidget(),
                          if (product.tags?.isNotEmpty == true)
                            BaseProductRowWidget(
                                title: '標　籤',
                                view: ProductTagsRowWidget(tags: product.tags!),
                                moreTapped: () => debugPrint('tap tags')),

                          // 分類
                          const ProductDividerWidget(),
                          if (product.categoryMain != null)
                            BaseProductRowWidget(
                                title: '分　類',
                                view: ProductCategoryRowWidget(
                                  categoryMain: product.categoryMain!,
                                )),
                        ],
                      )),

                  // 廣告
                  /*
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: ProductAd(
                            imageUrl: product.mockAd,
                            height: 78 * SizeConfig.screenRatio),
                      ),
                      */

                  // 商品介紹
                  ProductIntroductionWidget(
                      key: introductionKey, product: product),

                  // 推薦好貨
                  if (product.recomList?.isNotEmpty == true)
                    ProductRecommendWidget(
                        key: recommendKey, recomList: product.recomList!),
                  const SizedBox(height: 8)
                ],
              ),
            ),
          );
        },
      ));

  /// 錯誤頁
  Widget get _error => SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: const Center(child: CircularProgressIndicator()),
      );
}
