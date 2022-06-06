import 'package:brandstores/src/app/utils/screen_config.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../device/utils/my_plus_colors.dart';
import '../../../domain/entities/product/product.dart';
import '../../../extension/num_extension.dart';
import 'selected_border.dart';

// 商品類型
enum SmallProductType { addon, freebie }

class SmallProduct extends StatefulWidget {
  /// The callback that is called when the countdown timer is ended.
  final Product product;
  final SmallProductType type;
  // 點擊事件，若不需要點擊可傳 null
  //final ValueChanged<bool>? isSelected;
  final ValueChanged<Product>? onItemTap;

  const SmallProduct(
      {Key? key, required this.product, required this.type, this.onItemTap})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _SmallProductState();
}

class _SmallProductState extends State<SmallProduct> {
  bool isSelected = false;

  // 圖片網址
  String? get imageUrl {
    switch (widget.type) {
      case SmallProductType.addon:
        return widget.product.productInfo?.first.imageUrl;
      case SmallProductType.freebie:
        return widget.product.imageUrl;
    }
  }

// 價格
  String get price {
    String? name;
    switch (widget.type) {
      case SmallProductType.addon:
        name = widget.product.addonFixedPrice?.toDollarString();
        break;
      case SmallProductType.freebie:
        name =
            '買${widget.product.freebieBuyNum}送${widget.product.freebieGiftNum}';
        break;
    }
    return name ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () => {
              if (widget.onItemTap != null) {widget.onItemTap!(widget.product)}
              // if (widget.isSelected != null) {
              //   setState(() {
              //     isSelected = !isSelected;
              //     widget.isSelected!(isSelected);
              //   });
              // }
            },
        child: Column(
          children: <Widget>[
            SizedBox(
              width: 60,
              child: AspectRatio(
                  aspectRatio: 1,
                  child: Stack(
                    children: [
                      // 加購品圖片
                      _buildProductImage(imageUrl),
                      // 選取框
                      // if (widget.isSelected != null)
                      //   SelectedBorder(
                      //     isSelected: isSelected,
                      //   ),
                    ],
                  )),
            ),

            // 加購品價格
            Container(
                padding: EdgeInsets.only(top: 4 * SizeConfig.screenRatio),
                height: 17 * SizeConfig.screenRatio,
                child: FittedBox(
                    fit: BoxFit.contain,
                    child: Text(price,
                        style: Theme.of(context).textTheme.caption?.copyWith(
                            fontSize: 12.0,
                            color: (SmallProductType.freebie == widget.type &&
                                    widget.product.freebieisEmpty)
                                ? UdiColors.brownGreyTwo
                                : UdiColors.strawberry))))
          ],
        ));
  }

  Widget _buildProductImage(String? url) {
    return url != null
        ? AspectRatio(
            aspectRatio: 1,
            child: CachedNetworkImage(
              imageUrl: url,
              fit: BoxFit.fill,
              alignment: Alignment.topCenter,
              color: (SmallProductType.freebie == widget.type &&
                      widget.product.freebieisEmpty)
                  ? UdiColors.brownGreyTwo
                  : null,
              colorBlendMode: BlendMode.modulate,
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ))
        : const Icon(Icons.error);
  }
}
