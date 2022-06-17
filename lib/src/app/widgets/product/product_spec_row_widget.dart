import 'package:brandstores/src/device/utils/my_plus_colors.dart';
import 'package:flutter/material.dart';

import '../../../domain/entities/product/product.dart';

/// 促銷活動列
class ProductSpecRowWidget extends StatelessWidget {
  const ProductSpecRowWidget({Key? key, required this.product})
      : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    // 最多顯示兩筆
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      SizedBox(
        height: 20,
        child: FittedBox(
            fit: BoxFit.fitWidth,
            child: Text(product.defaultSpecText,
                style: Theme.of(context)
                    .textTheme
                    .caption
                    ?.copyWith(fontSize: 14.0, color: UdiColors.greyishBrown))),
      ),
      if (product.shippedNote != null)
        Container(
          padding: const EdgeInsets.only(top: 5),
          height: 20,
          child: FittedBox(
              fit: BoxFit.fitWidth,
              child: Text(product.shippedNote!,
                  style: Theme.of(context).textTheme.caption?.copyWith(
                      fontSize: 14.0, color: UdiColors.greyishBrown))),
        ),
    ]);
  }
}
