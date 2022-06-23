import 'package:brandstores/src/device/utils/my_plus_colors.dart';
import 'package:flutter/material.dart';

import '../../../domain/entities/product/product.dart';
import '../../utils/screen_config.dart';

/// 促銷活動列
class ProductSpecRowWidget extends StatelessWidget {
  const ProductSpecRowWidget({Key? key, required this.product, this.params})
      : super(key: key);

  final Product product;
  final AddToCartParams? params;

  @override
  Widget build(BuildContext context) {
    String? _preorderDate = product.getShippedNote(params?.deliveryDate);
    TextStyle? _strawberryStyle = Theme.of(context)
        .textTheme
        .caption
        ?.copyWith(fontSize: 14.0, color: UdiColors.strawberry);

    return DefaultTextStyle(
        style: Theme.of(context)
                .textTheme
                .caption
                ?.copyWith(fontSize: 14.0, color: UdiColors.greyishBrown) ??
            const TextStyle(),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          // 提示文字
          Wrap(children: [
            Text(product.getDefaultSpecText(params?.deliveryDate))
          ]),
          if (_preorderDate?.isNotEmpty == true)
            SizedBox(
              height: 5 * SizeConfig.screenRatio,
            ),
          if (_preorderDate?.isNotEmpty == true) Text(_preorderDate!),

          /*
              selectedAddons.isNotEmpty
                  ? Text.rich(TextSpan(children: [
                      const TextSpan(text: "已選購 "),
                      TextSpan(
                          text: selectedAddons.length.toString(),
                          style: _strawberryStyle),
                      const TextSpan(text: " 件，共 "),
                      TextSpan(
                          text: selectedAddons
                              .sumBy((e) => e.addonPrice ?? 0)
                              .toDollarString(),
                          style: _strawberryStyle),
                    ]))
                  : const Text('一起買，更優惠')),
*/
        ]));
  }
}
