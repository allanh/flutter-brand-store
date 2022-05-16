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
  final CarouselController _controller = CarouselController();

  List<Widget>? _getimageList(ProductController controller) {
    if (controller.product?.imageInfo != null) {
      return controller.product?.imageInfo?.map((i) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
                width: MediaQuery.of(context).size.width,
                /*
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 5.0),
                                    decoration:
                                        BoxDecoration(color: Colors.amber),
                                        */
                child: Image.network(
                  controller.product!.imageInfo!.first.url!,
                  fit: BoxFit.fill,
                ));
          },
        );
      }).toList();
    } else {
      return [Image.asset('assets/images/empty_cart.png')];
    }
  }

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
                    flexibleSpace: LayoutBuilder(
                      builder:
                          (BuildContext context, BoxConstraints constraints) {
                        // print('constraints=' + constraints.toString());
                        _top = constraints.biggest.height;
                        return FlexibleSpaceBar(
                            centerTitle: true,
                            title: AnimatedOpacity(
                                duration: const Duration(milliseconds: 300),
                                opacity: _top > 150 ? 0.0 : 1.0,
                                //opacity: innerBoxIsScrolled ? 1.0 : 0.0,
                                child: Text(
                                  _top.toString(),
                                  style: const TextStyle(fontSize: 18.0),
                                )),
                            background: _getSlider(controller));
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

  Widget _getSlider(ProductController controller) {
    return controller.product?.imageInfo != null
        ? CarouselSlider(
            options: CarouselOptions(
              height: 400.0,
              viewportFraction: 1.0,
              enableInfiniteScroll: false,
              enlargeCenterPage: false,
              // autoPlay: false,
            ),
            items: controller.product?.imageInfo
                ?.where(
                    (element) => element.url != null && element.type == 'IMAGE')
                .map((item) {
              debugPrint('2 image: ${item.url}');
              return Builder(
                builder: (BuildContext context) {
                  return SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: item.url != null
                          ? Image.network(
                              item.url!,
                              fit: BoxFit.fill,
                            )
                          : Image.asset('assets/images/empty_cart.png'));
                },
              );
            }).toList(),
          )
        : Image.asset('assets/images/empty_cart.png');

    /*
                   CachedNetworkImage(
                    imageUrl:
                        'https://storage.googleapis.com/udi_upload/0e09d77564308edd2da7b84ae39ef8cf',
                    fit: BoxFit.fitWidth,
                    alignment: Alignment.topCenter,
                    placeholder: (context, url) =>
                        const CircularProgressIndicator(
                      color: Colors.black,
                    ),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                  */
  }
}
