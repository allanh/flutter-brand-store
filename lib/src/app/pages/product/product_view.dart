import 'package:brandstores/src/app/utils/screen_config.dart';
import 'package:brandstores/src/app/widgets/product/event_countdown_timer.dart';
import 'package:brandstores/src/app/widgets/product/product_addon.dart';
import 'package:brandstores/src/device/utils/my_plus_colors.dart';
import 'package:brandstores/src/domain/entities/product/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../../widgets/product/base_product_row.dart';
import '../../widgets/product/image_slider.dart';
import '../../widgets/product/product_category.dart';
import '../../widgets/product/product_event.dart';
import '../../widgets/product/product_freebie.dart';
import '../../widgets/product/product_name.dart';
import '../../widgets/product/product_payment.dart';
import '../../widgets/product/product_shipped.dart';
import '../../widgets/product/product_spec.dart';
import '../../widgets/product/product_tags.dart';
import '../../widgets/product/promotion_price.dart';
import '../../widgets/product/promotion_tag.dart';
import './product_controller.dart';
import '../../../data/repositories/data_product_repository.dart';
import 'package:go_router/go_router.dart';

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
  // double _top = 0.0;
  final CarouselController carouselController = CarouselController();
  double get ratio => SizeConfig.screenRatio;
  double get _statusBarHeight => MediaQuery.of(context).padding.top;
  bool _showAppbar = false; //this is to show app bar
  final ScrollController _scrollBottomBarController =
      ScrollController(); // set controller on scrolling
  bool _isScrollingDown = false;

  // Tabbar
  final _tabs = ['商品', '介紹', '推薦'];
  TabBar get _tabBar => TabBar(
        labelColor: Theme.of(context).primaryColor,
        unselectedLabelColor: UdiColors.brownGrey,
        tabs: _tabs.map((String name) => Tab(text: name)).toList(),
      );

  @override
  Widget get view {
    return ControlledWidgetBuilder<ProductController>(
        builder: (context, controller) {
      return Scaffold(key: globalKey, body: _getHeader(controller));
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
      _showAppbar = isShow;
    });
  }

  // 增加監聽器
  void _initScrollListener() async {
    _scrollBottomBarController.addListener(() {
      if (_scrollBottomBarController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        if (!_isScrollingDown) {
          _isScrollingDown = true;
          _showTabbar(true);
        }
      }
      if (_scrollBottomBarController.position.userScrollDirection ==
          ScrollDirection.forward) {
        if (_isScrollingDown) {
          _isScrollingDown = false;
          _showTabbar(false);
        }
      }
    });
  }

  Widget _getHeader(ProductController controller) {
    return ControlledWidgetBuilder<ProductController>(
        builder: (context, controller) {
      return LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        return DefaultTabController(
            length: _tabs.length, // This is the number of tabs.
            child: Scaffold(
                extendBodyBehindAppBar: true,
                appBar: AppBar(
                  toolbarHeight: kToolbarHeight,
                  leading: InkWell(
                    onTap: () => context.pop(),
                    child: const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                    ),
                  ),
                  title: const Text('商品'),
                  centerTitle: true,
                  backgroundColor: Colors.black,
                  actions: [
                    // 購物車
                    IconButton(
                      icon: const Icon(Icons.shopping_cart),
                      onPressed: () {},
                    ),
                    // 更多動作
                    IconButton(
                      icon: const Icon(Icons.more_vert),
                      onPressed: () {},
                    )
                  ],
                  bottom: _showAppbar == true
                      ? PreferredSize(
                          preferredSize: Size.fromHeight(40 * ratio),
                          child: AnimatedOpacity(
                            duration: const Duration(milliseconds: 300),
                            opacity: 1.0,
                            child: ColoredBox(
                              color: Colors.white,
                              child: _tabBar,
                            ),
                          ))
                      : null,
                ),
                body: getBody(controller)));
      });
    });
  }

  Widget getBody(ProductController controller) {
    if (controller.product != null) {
      Product product = controller.product!;

      return Container(
          width: MediaQuery.of(context).size.width,
          color: UdiColors.white2,
          padding: EdgeInsets.only(top: _statusBarHeight + kToolbarHeight),
          child: LayoutBuilder(
            builder:
                (BuildContext context, BoxConstraints viewportConstraints) {
              return SingleChildScrollView(
                controller: _scrollBottomBarController,
                child: ConstrainedBox(
                  constraints:
                      BoxConstraints(minHeight: viewportConstraints.maxHeight),
                  child: Column(
                    children: [
                      // 圖片或影片
                      AspectRatio(
                        aspectRatio: 1.0,
                        child: Stack(children: [
                          ImageSlider(imageList: product.imageInfo ?? []),
                          // 圖標
                          if (product.productInfo?.isNotEmpty == true)
                            PromotionTagsView(product: product),
                        ]),
                      ),

                      // 倒數計時
                      if (product.countdownDuration != null)
                        EventCountDownTimer(
                          duration: product.countdownDuration!,
                          type: (product.status == ProductStatus.comingSoon)
                              ? CountDownType.comingSoon
                              : CountDownType.flashSale,
                          slogan: product.promotionApp?.slogan,
                          onTimerEned: () => controller.onCountDownEnd(),
                        ),

                      // 商品名稱
                      ProductName(product: controller.product),

                      // 促銷活動
                      if (product.eventList?.isNotEmpty == true)
                        BaseProductRow(
                            title: '活　動',
                            marginTop: 8,
                            view: ProductEventsView(
                              //eventList: product.mockEvents,
                              eventList: product.eventList!,
                            ),
                            onMoreTap: () => debugPrint('tap event')),

                      // 獨享價
                      if ((product.product?.promotionPriceAppDiff ?? 0) > 0)
                        BaseProductRow(
                            title: '獨享價',
                            marginTop: 8,
                            view: PromotionPriceView(
                              promotionPrice:
                                  product.product!.promotionPriceAppDiff!,
                            )),

                      // 規格
                      if (product.product != null)
                        BaseProductRow(
                            title: '規　格',
                            marginTop: 8,
                            view: ProductSpecView(
                              product: product,
                            ),
                            onMoreTap: () => debugPrint('tap spac')),

                      // 加購品
                      if (product.addonInfo?.isNotEmpty == true)
                        BaseProductRow(
                            title: '加價購',
                            marginTop: 8,
                            view: ProductAddonView(
                              addons: product.addonInfo!,
                              //addons: product.mockAddons,
                              selectedAddons: [],
                            ),
                            onMoreTap: () => debugPrint('tap addon')),

                      // 買就送
                      if (product.freebieInfo?.isNotEmpty == true)
                        BaseProductRow(
                            title: '買就送',
                            marginTop: 8,
                            view: ProductFreeBieView(
                              freeBies: product.freebieInfo!,
                            ),
                            onMoreTap: () => debugPrint('tap freebie')),

                      // 付款和運送方式
                      Container(
                          margin: const EdgeInsets.only(top: 8),
                          color: Colors.white,
                          child: Column(
                            children: [
                              if (product.paymentInfo != null &&
                                  product.productInfo!.first.proposedPrice !=
                                      null)
                                BaseProductRow(
                                    title: '付　款',
                                    view: ProductPayment(
                                      price: product
                                          .productInfo!.first.proposedPrice!,
                                      info: product.paymentInfo!,
                                    ),
                                    onMoreTap: () => debugPrint('tap payment')),
                              _smallDivider,
                              if (product.shippedMethod?.isNotEmpty == true)
                                BaseProductRow(
                                  title: '運　送',
                                  view: ProductShipped(
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
                              BaseProductRow(
                                  title: '編　號',
                                  view: Text('${product.no}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .caption
                                          ?.copyWith(
                                              fontSize: 14.0,
                                              color: UdiColors.greyishBrown))),

                              // 品牌
                              _smallDivider,
                              if (product.brandName != null)
                                BaseProductRow(
                                  title: '品　牌',
                                  view: Text('${product.brandName}',
                                      textAlign: TextAlign.left,
                                      style: Theme.of(context)
                                          .textTheme
                                          .caption
                                          ?.copyWith(
                                              fontSize: 14.0,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              decoration:
                                                  TextDecoration.underline)),
                                ),

                              // 標籤
                              if (product.tags?.isNotEmpty == true)
                                _smallDivider,
                              if (product.tags?.isNotEmpty == true)
                                BaseProductRow(
                                    title: '標　籤',
                                    view: ProductTagsView(tags: product.tags!),
                                    onMoreTap: () => debugPrint('tap tags')),

                              // 分類
                              _smallDivider,
                              if (product.categoryMain != null)
                                BaseProductRow(
                                    title: '分　類',
                                    view: ProductCategoryView(
                                      categoryMain: product.categoryMain!,
                                    )),
                            ],
                          )),
                    ],
                  ),
                ),
              );
            },
          ));
    } else {
      return SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: const Center(child: CircularProgressIndicator()),
      );
    }
  }

  Widget get _divider => Container(
      width: SizeConfig.screenWidth - 24,
      height: 1,
      decoration: const BoxDecoration(color: UdiColors.defaultBorder));

  Widget get _smallDivider => Container(
      width: SizeConfig.screenWidth - 24,
      height: 1,
      decoration: const BoxDecoration(color: UdiColors.defaultBorder));
}
