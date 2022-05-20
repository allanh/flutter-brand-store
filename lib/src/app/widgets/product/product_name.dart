import 'package:brandstores/src/app/utils/colors.dart';
import 'package:brandstores/src/domain/entities/product/promotion.dart';
import 'package:flutter/material.dart';

import '../../../domain/entities/product/product.dart';
import '../../../extension/int_extension.dart';

/// 單一圖標
class ProductName extends StatelessWidget {
  const ProductName({Key? key, required this.product}) : super(key: key);

  final Product? product;

  @override
  Widget build(BuildContext context) => Container(
      alignment: Alignment.topLeft,
      padding: const EdgeInsets.only(top: 8, bottom: 8, left: 12, right: 12),
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(color: Colors.white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            product?.name ?? '',
            textAlign: TextAlign.left,
            style: const TextStyle(
                fontFamily: 'PingFangTC-Semibold', fontSize: 16.0),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // 網路價
                Text(
                  product?.product?.proposedPrice?.toDollarString() ?? '',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      height: 1.42857,
                      color: MyPlusColor.strawberry,
                      fontFamily: 'PingFangTC-Semibold',
                      fontSize: 28.0),
                ),
                // 浮動價格
                if (product?.isRangePrice ?? false)
                  Padding(
                      padding:
                          const EdgeInsets.only(left: 8, right: 8, bottom: 3),
                      child: Text(
                        '起',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            height: 1.71428,
                            color: MyPlusColor.strawberry,
                            fontFamily: 'PingFangTC-Semibold',
                            fontSize: 14.0),
                      )),
                // 市價
                Padding(
                    padding:
                        const EdgeInsets.only(left: 8, right: 8, bottom: 3),
                    child: Text(
                      product?.product?.marketPrice?.toDollarString() ?? '',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          decoration: TextDecoration.lineThrough,
                          height: 1.71428,
                          color: MyPlusColor.brownGrey,
                          fontFamily: 'PingFangTC-Semibold',
                          fontSize: 14.0),
                    )),
                // 折扣折數
                if (product?.promotionApp?.type == PromotionType.rate)
                  Container(
                    height: 24,
                    padding: const EdgeInsets.only(
                        top: 3, bottom: 3, left: 6, right: 6),
                    margin: const EdgeInsets.only(bottom: 3),
                    decoration: BoxDecoration(
                        color: MyPlusColor.strawberry,
                        borderRadius: BorderRadius.circular(2)),
                    child: Text(
                      '${product?.promotionApp?.rate ?? ''}折',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          color: Colors.white,
                          fontFamily: 'PingFangTC-Regular',
                          fontSize: 12.0),
                    ),
                  ),
              ],
            ),
          )
        ],
      ));
}
