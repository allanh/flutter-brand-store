import 'package:brandstores/src/app/widgets/product/promotion_tag.dart';
import 'package:brandstores/src/domain/entities/product/promotion.dart';
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
      height: 375.0,
      child: Stack(children: [
        // 圖片或影片
        ImageSlider(imageList: controller.product?.imageInfo ?? []),
        // 圖標
        if (controller.product?.productInfo?.isNotEmpty == true)
          PromotionTagsView(product: controller.product!),
      ]));

/*
  @override
  Widget get view {
    return ControlledWidgetBuilder<ProductController>(
        builder: (context, controller) {
      return Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverOverlapAbsorber(
                  handle:
                      NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                  sliver: SliverAppBar(
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
                    expandedHeight: 375.0,
                    backgroundColor: Colors.black,
                    flexibleSpace: LayoutBuilder(
                      builder:
                          (BuildContext context, BoxConstraints constraints) {
                        _top = constraints.biggest.height;
                        return FlexibleSpaceBar(
                            centerTitle: true,
                            title: AnimatedOpacity(
                                duration: const Duration(milliseconds: 300),
                                opacity: _top > 150 ? 0.0 : 1.0,
                                child: const Text(
                                  '商品',
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    fontFamily:
                                        'PingFangTC-Semibold,PingFang TC',
                                  ),
                                )),
                            background: ImageSlider(
                                imageList:
                                    controller.product?.imageInfo ?? []));
                      },
                    ),
                  )),
            ];
          },
          body: Builder(builder: (BuildContext context) {
            return CustomScrollView(
              slivers: [
                SliverOverlapInjector(
                  // This is the flip side of the SliverOverlapAbsorber above.
                  handle:
                      NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                ),
                SliverToBoxAdapter(
                  child: Container(
                    height: 200,
                    color: Colors.red,
                  ),
                ),
              ],
            );
          }),
        ),
      );
    });
  }
  */
}
