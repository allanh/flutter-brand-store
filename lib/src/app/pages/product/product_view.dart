import 'package:brandstores/src/app/widgets/product/event_countdown_timer.dart';
import 'package:brandstores/src/app/widgets/product/promotion_tag.dart';
import 'package:brandstores/src/domain/entities/product/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../../widgets/product/image_slider.dart';
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
      debugPrint('${controller.product?.countdownDuration}');
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
        title: const Text(
          '商品',
          style: TextStyle(
              fontFamily: 'PingFangTC-Semibold',
              fontSize: 18.0,
              color: Colors.white),
        ),
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

  Widget getBody(ProductController controller) => SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(children: [
            // 圖片或影片
            ImageSlider(imageList: controller.product?.imageInfo ?? []),
            // 圖標
            if (controller.product?.productInfo?.isNotEmpty == true)
              PromotionTagsView(product: controller.product!),
          ]),
          // 倒數計時
          if (controller.product?.countdownDuration != null)
            EventCountDownTimer(
                duration: controller.product!.countdownDuration!,
                type: (controller.product?.status == ProductStatus.comingSoon)
                    ? CountDownType.comingSoon
                    : CountDownType.flashSale)
        ],
      ));
}
