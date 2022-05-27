import 'package:brandstores/src/app/widgets/product/event_countdown_timer.dart';
import 'package:brandstores/src/app/widgets/product/promotion_tag.dart';
import 'package:brandstores/src/domain/entities/product/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../../../device/utils/my_plus_colors.dart';
import '../../widgets/product/base_product_row.dart';
import '../../widgets/product/event.dart';
import '../../widgets/product/image_slider.dart';
import '../../widgets/product/product_name.dart';
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

  @override
  Widget get view {
    return ControlledWidgetBuilder<ProductController>(
        builder: (context, controller) {
      return Scaffold(
          key: globalKey,
          appBar: getAppBar(controller),
          body: getBody(controller));
    });
  }

  AppBar getAppBar(ProductController controller) => AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => context.pop(),
        ),
        title: const Text('商品'),
        centerTitle: true,
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {},
          )
        ],
      );

  Widget getBody(ProductController controller) => (controller.product != null)
      ? Container(
          width: MediaQuery.of(context).size.width,
          color: UdiColors.white2,
          child: SingleChildScrollView(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 圖片或影片
              AspectRatio(
                aspectRatio: 1.0,
                child: Stack(children: [
                  ImageSlider(imageList: controller.product?.imageInfo ?? []),
                  // 圖標
                  if (controller.product?.productInfo?.isNotEmpty == true)
                    PromotionTagsView(product: controller.product!),
                ]),
              ),

              // 倒數計時
              if (controller.product?.countdownDuration != null)
                EventCountDownTimer(
                  duration: controller.product!.countdownDuration!,
                  type: (controller.product?.status == ProductStatus.comingSoon)
                      ? CountDownType.comingSoon
                      : CountDownType.flashSale,
                  slogan: controller.product?.promotionApp?.slogan,
                  onTimerEned: () => controller.onCountDownEnd(),
                ),

              // 商品名稱
              ProductName(product: controller.product),

              // 促銷活動
              if (controller.product?.eventList?.isNotEmpty == true)
                BaseProductRow(
                    title: '活　動',
                    view: ProductEventsView(
                      //eventList: controller.product!.mockEvents,
                      eventList: controller.product!.eventList!,
                    ),
                    onMoreTap: () => debugPrint('tap event')),

              // 獨享價
              if ((controller.product?.product?.promotionPriceAppDiff ?? 0) > 0)
                BaseProductRow(
                    title: '獨享價',
                    view: PromotionPriceView(
                      promotionPrice:
                          controller.product!.product!.promotionPriceAppDiff!,
                    ),
                    onMoreTap: () => debugPrint('tap event')),
              // 規格
            ],
          )))
      : SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: const Center(child: CircularProgressIndicator()),
        );
}
