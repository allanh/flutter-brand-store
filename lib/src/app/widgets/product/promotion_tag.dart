import 'package:brandstores/src/app/utils/constants.dart';
import 'package:flutter/material.dart';

import '../../../domain/entities/product/product.dart';
import '../../../domain/entities/product/promotion.dart';

/// 單一圖標
class PromotionTag extends StatelessWidget {
  const PromotionTag({Key? key, required this.tagText, required this.image})
      : super(key: key);

  final String tagText;
  final String image;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
        padding: const EdgeInsets.only(top: 3, bottom: 3),
        child: SizedBox(
            width: 40,
            height: 40,
            child: Container(
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage(image)),
              ),
              padding: const EdgeInsets.only(left: 3, right: 3),
              child: Text(
                tagText,
                textAlign: TextAlign.center,
                style: theme.textTheme.headline6!
                    .copyWith(height: 1.142857, fontSize: 14),
              ),
            )));
  }
}

/// 全部圖標
class PromotionTagsView extends StatelessWidget {
  const PromotionTagsView({Key? key, required this.product}) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    if (product.productInfo?.isEmpty == true) {
      return const SizedBox.shrink();
    }
    final info = product.productInfo?.first;
    final promotionRate = product.promotionApp?.type == PromotionType.rate
        ? product.promotionApp?.rate
        : '';

    return Padding(
        padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
        child: SizedBox(
            width: 40.0,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (info?.tag?.lowQuantity == true)
                    PromotionTag(
                        tagText: '最後${info?.quantity ?? ''}件',
                        image: 'assets/images/icon_product_tag_label_01.png'),
                  if (info?.tagProd?.flashSale == true && promotionRate != null)
                    PromotionTag(
                        tagText: '限時$promotionRate折',
                        image: 'assets/images/icon_product_tag_label_01.png'),
                  if (info?.tagProd?.isNew == true)
                    const PromotionTag(
                        tagText: '新貨架到',
                        image: 'assets/images/icon_product_tag_label_02.png'),
                  if (info?.tagProd?.istop10Sale == true)
                    const PromotionTag(
                        tagText: '口碑暢銷',
                        image: 'assets/images/icon_product_tag_label_03.png'),
                  if (info?.tagProd?.istop10Favorite == true)
                    const PromotionTag(
                        tagText: '精選收藏',
                        image: 'assets/images/icon_product_tag_label_04.png'),
                ])));
  }
}
