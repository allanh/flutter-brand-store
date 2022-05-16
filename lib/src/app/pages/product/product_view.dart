import './product_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
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

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget get view {
    return ControlledWidgetBuilder<ProductController>(
      builder: (context, controller) {
        // if (controller.product != null) {
        return Scaffold(
          body: CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                expandedHeight: 250.0,
                flexibleSpace: FlexibleSpaceBar(
                  title: const Text('商品', textScaleFactor: 1),
                  background: controller.product?.imageInfo?.first.url != null
                      ? Image.network(
                          controller.product!.imageInfo!.first.url!,
                          fit: BoxFit.fill,
                        )
                      : Image.asset('assets/images/empty_cart.png'),
                ),
                floating: false,
                pinned: true,
                snap: false,
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () => context.pop(),
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (_, int index) {
                    return ListTile(
                      leading: Container(
                          padding: EdgeInsets.all(8),
                          width: 100,
                          child: Placeholder()),
                      title: Text('Place ${index + 1}', textScaleFactor: 2),
                    );
                  },
                  childCount: 20,
                ),
              ),
            ],
          ), // This trailing comma makes auto-formatting nicer for build methods.
        );
        // }
        // return const CircularProgressIndicator();
      },
    );
  }
}
