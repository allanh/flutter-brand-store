import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../device/utils/my_plus_colors.dart';
import '../../../domain/entities/product/product.dart';
import '../../../extension/num_extension.dart';
import '../member/center/horizontal_product_list_card.dart';

class ProductItemWidget extends StatelessWidget {
  final Product product;
  final int? productId;
  final ValueChanged<Product>? onItemTapped;

  const ProductItemWidget(
      {Key? key, required this.product, this.productId, this.onItemTapped})
      : super(key: key);

// 價格
  String get _price {
    int? _price;
    if (productId != null) {
      _price = product.getProudctInfo(productId: productId!)?.proposedPrice;
    } else if (product.productInfo?.isNotEmpty == true) {
      _price = product.productInfo?.first.proposedPrice;
    }
    return _price != null ? _price.toDollarString() : '無法取得價格';
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 140,
        height: 236,
        child: InkWell(
            onTap: () => {
                  if (onItemTapped != null) {onItemTapped!(product)}
                },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // 商品圖片
                AspectRatio(
                    aspectRatio: 1,
                    child: Stack(
                      children: [
                        _buildProductImage(product.imageUrl),
                      ],
                    )),

                const SizedBox(height: 8),
                if (product.name != null)
                  SizedBox(
                      height: 48,
                      child: Text(product.name!,
                          maxLines: 2,
                          style: Theme.of(context).textTheme.caption?.copyWith(
                              height: 1.714, // 24pt
                              fontSize: 14.0,
                              color: UdiColors.greyishBrown))),

                //const SizedBox(height: 8),
                // 商品價格
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    /// 價格
                    Expanded(
                        flex: 2,
                        child: Text(_price,
                            style:
                                Theme.of(context).textTheme.headline6?.copyWith(
                                    height: 1.375, // 22pt
                                    fontSize: 16.0,
                                    color: UdiColors.strawberry))),

                    /// 收藏按鈕
                    const Expanded(flex: 1, child: FavoriteButton())
                  ],
                ),
                /*
                    FittedBox(
                        fit: BoxFit.contain,
                        child: Text(_price,
                            style:
                                Theme.of(context).textTheme.headline6?.copyWith(
                                    height: 1.375, // 22pt
                                    fontSize: 16.0,
                                    color: UdiColors.strawberry)))*/
              ],
            )));
  }

  /// 商品圖片
  Widget _buildProductImage(String? url) {
    return url != null
        ? AspectRatio(
            aspectRatio: 1,
            child: CachedNetworkImage(
              imageUrl: url,
              fit: BoxFit.fill,
              alignment: Alignment.topCenter,
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ))
        : const Icon(Icons.error);
  }
}
