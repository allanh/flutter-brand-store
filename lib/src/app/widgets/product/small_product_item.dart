import 'package:brandstores/src/app/utils/screen_config.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../device/utils/my_plus_colors.dart';
import '../../../domain/entities/product/product.dart';
import '../../../extension/num_extension.dart';
import 'selected_border.dart';

// 商品類型
enum SmallProductItemType { addon, freebie }

class SmallProductItem extends StatefulWidget {
  /// The callback that is called when the countdown timer is ended.
  final Product product;
  final SmallProductItemType type;
  // 點擊事件，若不需要點擊可傳 null
  //final ValueChanged<bool>? isSelected;
  final ValueChanged<Product>? onTapItem;

  const SmallProductItem(
      {Key? key, required this.product, required this.type, this.onTapItem})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _SmallProductItemState();
}

class _SmallProductItemState extends State<SmallProductItem> {
  //bool _isSelected = false;

  // 圖片網址
  String? get _imageUrl {
    switch (widget.type) {
      case SmallProductItemType.addon:
        return widget.product.productInfo?.first.imageUrl;
      case SmallProductItemType.freebie:
        return widget.product.imageUrl;
    }
  }

// 價格
  String get _price {
    String? name;
    switch (widget.type) {
      case SmallProductItemType.addon:
        name = widget.product.addonFixedPrice?.toDollarString();
        break;
      case SmallProductItemType.freebie:
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
              if (widget.onTapItem != null) {widget.onTapItem!(widget.product)}
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
                      // 商品圖片
                      _buildProductImage(_imageUrl),
                      // 選取框
                      // if (widget.isSelected != null)
                      //   SelectedBorder(
                      //     isSelected: isSelected,
                      //   ),
                    ],
                  )),
            ),
            const SizedBox(height: 4),
            // 商品價格
            FittedBox(
                fit: BoxFit.contain,
                child: Text(_price,
                    style: Theme.of(context).textTheme.caption?.copyWith(
                        height: 1.4166, // 17pt
                        fontSize: 12.0,
                        color: (SmallProductItemType.freebie == widget.type &&
                                widget.product.freebieisEmpty)
                            ? UdiColors.brownGreyTwo
                            : UdiColors.strawberry)))
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
              color: (SmallProductItemType.freebie == widget.type &&
                      widget.product.freebieisEmpty)
                  ? UdiColors.brownGreyTwo
                  : null,
              colorBlendMode: BlendMode.modulate,
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ))
        : const Icon(Icons.error);
  }
}
