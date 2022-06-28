import 'package:flutter/material.dart';
import '../../../domain/entities/product/product.dart';
import 'full_image/image_slider_widget.dart';
import 'promotion_tag_row_widget.dart';

class ProductFlexibleSpaceBarWidget extends StatelessWidget {
  const ProductFlexibleSpaceBarWidget({Key? key, this.product})
      : super(key: key);

  final Product? product;

  @override
  Widget build(BuildContext context) {
    double _top = 0;
    double _statusBarHeight = MediaQuery.of(context).padding.top;

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        _top = constraints.biggest.height;
        return FlexibleSpaceBar(
            centerTitle: true,
            title: AnimatedOpacity(
                duration: const Duration(milliseconds: 300),
                opacity: _top > 130 ? 0.0 : 1.0,
                child: const Text(
                  '商品',
                )),
            //titlePadding: EdgeInsets.only(bottom: 75 * SizeConfig.screenRatio),
            background:
                // 圖片畫廊
                AspectRatio(
              aspectRatio: 1.0,
              child: Padding(
                padding: EdgeInsets.only(top: _statusBarHeight),
                child: (product != null)
                    ? Stack(children: [
                        ImageSliderWidget(imageList: product!.mediaList ?? []),
                        // 圖標
                        if (product!.productInfo!.isNotEmpty == true)
                          PromotionTagsWidget(product: product!),
                      ])
                    : const Center(child: CircularProgressIndicator()),
              ),
            ));
      },
    );
  }
}
