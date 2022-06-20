import 'package:brandstores/src/domain/entities/product/promotion.dart';
import 'package:flutter/material.dart';

import '../../../device/utils/my_plus_colors.dart';
import '../../../domain/entities/product/product.dart';
import '../../../extension/num_extension.dart';
import '../../utils/screen_config.dart';

/// 單一圖標
class ProductName extends StatelessWidget {
  const ProductName({Key? key, required this.product}) : super(key: key);

  final Product? product;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
        alignment: Alignment.topLeft,
        padding: const EdgeInsets.only(top: 8, bottom: 8, left: 12, right: 12),
        width: SizeConfig.screenWidth,
        decoration: const BoxDecoration(color: Colors.white),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              product?.name ?? '',
              textAlign: TextAlign.left,
              style: theme.textTheme.headline6!
                  .copyWith(fontSize: 16, color: Colors.black),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  if (product?.product?.proposedPrice != null)
                    // 網路價
                    Text(
                        product?.product?.proposedPrice?.toDollarString() ?? '',
                        textAlign: TextAlign.left,
                        style: theme.textTheme.headline6!.copyWith(
                            color: UdiColors.strawberry, fontSize: 28.0)),
                  // 浮動價格
                  if (product?.isRangePrice ?? false)
                    Padding(
                        padding:
                            const EdgeInsets.only(left: 8, right: 8, bottom: 3),
                        child: Text(
                          '起',
                          textAlign: TextAlign.left,
                          style: theme.textTheme.caption!
                              .copyWith(color: UdiColors.strawberry),
                        )),
                  // 市價
                  Padding(
                      padding:
                          const EdgeInsets.only(left: 8, right: 8, bottom: 3),
                      child: Text(
                        product?.product?.marketPrice?.toDollarString() ?? '',
                        textAlign: TextAlign.left,
                        style: theme.textTheme.caption!.copyWith(
                          color: UdiColors.brownGrey,
                          decoration: TextDecoration.lineThrough,
                        ),
                      )),
                  // 折扣折數
                  if (product?.promotionApp?.type == PromotionType.rate)
                    Container(
                      height: 24,
                      padding: const EdgeInsets.only(
                          top: 3, bottom: 3, left: 6, right: 6),
                      margin: const EdgeInsets.only(bottom: 3),
                      decoration: BoxDecoration(
                          color: UdiColors.strawberry,
                          borderRadius: BorderRadius.circular(2)),
                      child: Text(
                        '${product?.promotionApp?.rate ?? ''}折',
                        textAlign: TextAlign.center,
                        style: theme.textTheme.caption!
                            .copyWith(fontSize: 12.0, color: Colors.white),
                      ),
                    ),
                ],
              ),
            )
          ],
        ));
  }
}
