import 'package:brandstores/src/app/utils/screen_config.dart';
import 'package:brandstores/src/device/utils/my_plus_colors.dart';
import 'package:flutter/material.dart';

import '../../../domain/entities/link.dart';
import '../../../domain/entities/product/product.dart';
import 'product_item.dart';

class ProductRecommend extends StatelessWidget {
  const ProductRecommend({Key? key, required this.recomList, this.onTapItem})
      : super(key: key);

  final List<Product> recomList;

  /// The callback that is called when the item is tapped.
  final ValueChanged<Link>? onTapItem;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(top: 8),
        height: 296,
        color: Colors.white,
        child: Column(children: [
          const SizedBox(height: 8),
          _title(context),
          const SizedBox(height: 8),
          Expanded(
              child: ListView.separated(
            itemCount: recomList.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Padding(
                  padding: EdgeInsets.only(
                      left: index == 0 ? 12 : 0,
                      right: index == (recomList.length - 1) ? 12 : 0),
                  child: ProductItem(
                    product: recomList[index],
                    onTapItem: (link) => {
                      if (onTapItem != null)
                        {onTapItem!(Link(LinkType.product, null))}
                    },
                  ));
            },
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(
                width: 12,
              );
            },
          ))
        ]));
  }

  // 標題
  Widget _title(BuildContext context) => SizedBox(
      height: 36,
      child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
        const SizedBox(width: 12),
        Container(
          width: 3,
          height: 24,
          decoration: BoxDecoration(color: Theme.of(context).primaryColor),
        ),
        const SizedBox(width: 8),
        Text('推薦好貨',
            style: Theme.of(context)
                .textTheme
                .headline6
                ?.copyWith(fontSize: 16.0, color: UdiColors.greyishBrown)
                .copyWith(height: 1.375)),
      ]));
}
