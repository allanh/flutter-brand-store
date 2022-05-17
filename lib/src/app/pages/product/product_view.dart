import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:carousel_slider/carousel_slider.dart';
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
  int _current = 0;
  double _top = 0.0;
  final CarouselController carouselController = CarouselController();

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
                    expandedHeight: 300.0,
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
                            background: _getBackground(controller));
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
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 200,
                      color: Colors.green,
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Container(
                    height: 200,
                    color: Colors.blue,
                  ),
                ),
                SliverToBoxAdapter(
                  child: Container(
                    height: 200,
                    color: Colors.red,
                  ),
                ),
                SliverToBoxAdapter(
                  child: Container(
                    height: 200,
                    color: Colors.blue,
                  ),
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

  Widget _getBackground(ProductController controller) {
    return controller.product?.imageInfo != null
        ? Stack(alignment: AlignmentDirectional.bottomCenter, children: [
            CarouselSlider(
              options: CarouselOptions(
                  height: 400.0,
                  viewportFraction: 1.0,
                  enableInfiniteScroll: false,
                  enlargeCenterPage: false,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _current = index;
                    });
                  }),
              carouselController: carouselController,
              items: controller.product?.imageList?.map((item) {
                return Builder(
                  builder: (BuildContext context) {
                    return SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: CachedNetworkImage(
                          imageUrl: item,
                          fit: BoxFit.fill,
                          alignment: Alignment.topCenter,
                          placeholder: (context, url) =>
                              const CircularProgressIndicator(),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        )
                        //: Image.asset('assets/images/empty_cart.png')
                        );
                  },
                );
              }).toList(),
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: controller.product?.imageList != null
                    ? controller.product!.imageList!
                        .asMap()
                        .entries
                        .map((entry) {
                        return GestureDetector(
                          onTap: () =>
                              carouselController.animateToPage(entry.key),
                          child: Container(
                            width: 12.0,
                            height: 12.0,
                            margin: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 4.0),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: (Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? Colors.white
                                        : Colors.black)
                                    .withOpacity(
                                        _current == entry.key ? 0.9 : 0.4)),
                          ),
                        );
                      }).toList()
                    : [])
          ])
        : Image.asset('assets/images/empty_cart.png');
  }
}
