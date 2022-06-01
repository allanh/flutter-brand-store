import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../device/utils/my_plus_colors.dart';
import '../../../domain/entities/product/product.dart';
import '../../../extension/num_extension.dart';
import 'selected_border.dart';

class SmallProduct extends StatefulWidget {
  /// The callback that is called when the countdown timer is ended.
  final Product product;
  // 點擊事件，若不需要點擊可傳 null
  final ValueChanged<bool>? isSelected;
  final double ratio;

  const SmallProduct(
      {Key? key, required this.product, required this.ratio, this.isSelected})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _SmallProductState();
}

class _SmallProductState extends State<SmallProduct> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          if (widget.isSelected != null) {
            setState(() {
              isSelected = !isSelected;
              //widget.isSelected!(isSelected);
            });
          }
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
                      _buildProductImage(widget.product.imageList?.first),
                      // 選取框
                      if (widget.isSelected != null)
                        SelectedBorder(
                          isSelected: isSelected,
                        ),
                    ],
                  )),
            ),

            // 加購品價格
            if (widget.product.addonFixedPrice != null)
              Container(
                  padding: EdgeInsets.only(top: 4 * widget.ratio),
                  height: 17 * widget.ratio,
                  child: FittedBox(
                      fit: BoxFit.contain,
                      child: Text(
                          widget.product.addonFixedPrice!.toDollarString(),
                          style: Theme.of(context).textTheme.caption?.copyWith(
                              fontSize: 12.0, color: UdiColors.greyishBrown))))
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
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ))
        : const Icon(Icons.error);
  }
}
