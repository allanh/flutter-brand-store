import 'package:brandstores/src/app/utils/screen_config.dart';
import 'package:brandstores/src/app/widgets/product/event_countdown_timer.dart';
import 'package:brandstores/src/app/widgets/product/product_addon.dart';
import 'package:brandstores/src/device/utils/my_plus_colors.dart';
import 'package:brandstores/src/domain/entities/product/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../../widgets/product/base_product_row.dart';
import '../../widgets/product/product_event.dart';
import '../../widgets/product/product_flexible_space_bar.dart';
import '../../widgets/product/product_name.dart';
import '../../widgets/product/product_spec.dart';
import '../../widgets/product/promotion_price.dart';
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
  double _top = 0;

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

  Widget _getHeader(ProductController controller) {
    return ControlledWidgetBuilder<ProductController>(
        builder: (context, controller) {
      return LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        _top = constraints.biggest.height;
        return DefaultTabController(
            length: _tabs.length, // This is the number of tabs.
            child: Scaffold(
              body: NestedScrollView(
                headerSliverBuilder:
                    (BuildContext context, bool innerBoxIsScrolled) {
                  return <Widget>[
                    SliverOverlapAbsorber(
                        handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                            context),
                        sliver: SliverAppBar(
                            // 倒退鍵
                            leading: InkWell(
                              onTap: () => context.pop(),
                              child: const Icon(
                                Icons.arrow_back_ios,
                                color: Colors.white,
                              ),
                            ),
                            pinned: true,
                            //floating: true,
                            stretch: true,
                            expandedHeight: 375.0 * ratio,
                            backgroundColor: Colors.black,
                            flexibleSpace: ProductFlexibleSpaceBar(
                                product: controller.product),
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
                            bottom: PreferredSize(
                              preferredSize: _tabBar.preferredSize,
                              child: ColoredBox(
                                color: Colors.white,
                                child: _tabBar,
                              ),
                            ))),
                  ];
                },
                body: Builder(builder: (BuildContext context) {
                  return CustomScrollView(
                    slivers: _slivers(context, controller),
                  );
                }),
              ),
            ));
      });
    });
  }

  // 商品內容列表
  List<Widget> _slivers(BuildContext context, ProductController controller) {
    List<Widget> list = [
      SliverOverlapInjector(
        // This is the flip side of the SliverOverlapAbsorber above.
        handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
      ),
    ];

    // 未取得商品
    if (controller.product == null) {
      list.add(SliverToBoxAdapter(
          child: SizedBox(
        width: SizeConfig.screenWidth,
        height: SizeConfig.screenHeight,
        child: const Center(child: CircularProgressIndicator()),
      )));
      return list;
    }

    Product product = controller.product!;

    // 倒數計時
    if (product.countdownDuration != null) {
      list.add(SliverToBoxAdapter(
          child: EventCountDownTimer(
        duration: product.countdownDuration!,
        type: (product.status == ProductStatus.comingSoon)
            ? CountDownType.comingSoon
            : CountDownType.flashSale,
        slogan: product.promotionApp?.slogan,
        onTimerEned: () => controller.onCountDownEnd(),
      )));
    }

    // 商品名稱
    list.add(
        SliverToBoxAdapter(child: ProductName(product: controller.product)));

    // 促銷活動
    if (product.eventList?.isNotEmpty == true) {
      list.add(SliverToBoxAdapter(
          child: BaseProductRow(
              title: '活　動',
              view: ProductEventsView(
                // eventList: product.mockEvents,
                eventList: product.eventList!,
              ),
              onMoreTap: () => debugPrint('tap event'))));
    }

    // 獨享價
    if ((product.product?.promotionPriceAppDiff ?? 0) > 0) {
      list.add(SliverToBoxAdapter(
        child: BaseProductRow(
            title: '獨享價',
            view: PromotionPriceView(
              promotionPrice: product.product!.promotionPriceAppDiff!,
            )),
      ));
    }

    // 規格
    // TODO: 選規
    list.add(SliverToBoxAdapter(
        child: BaseProductRow(
            title: '規　格',
            view: ProductSpecView(
              product: product,
            ),
            onMoreTap: () => debugPrint('tap spac'))));

    // 加價購
    // TODO: 加價購選規
    if (product.addonInfo?.isNotEmpty == true) {
      list.add(SliverToBoxAdapter(
          child: BaseProductRow(
              title: '加價購',
              view: ProductAddonView(
                addons: product.addonInfo!,
                //addons: product.mockAddons,
                selectedAddons: [],
              ),
              onMoreTap: () => debugPrint('tap addon'))));
    }

    return list;
  }
}
