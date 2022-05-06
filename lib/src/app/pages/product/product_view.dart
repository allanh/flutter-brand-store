import './product_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import '../../../data/repositories/data_product_repository.dart';

class ProductPage extends View {
  ProductPage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _ProductPageState createState() =>
      // inject dependencies inwards
      _ProductPageState();
}

class _ProductPageState extends ViewState<ProductPage, ProductController> {
  _ProductPageState() : super(ProductController(DataProductRepository()));

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
                  title: Text('Test', textScaleFactor: 1),
                  background: Image.network(
                    controller.product?.imageInfo?.first.url ?? 'assert',
                    fit: BoxFit.fill,
                  ),
                ),
                floating: false,
                pinned: true,
                snap: false,
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {},
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
