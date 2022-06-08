import 'package:brandstores/src/device/utils/my_plus_colors.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';

import '../../../domain/entities/product/category_main.dart';

/// 分類列
class ProductCategoryView extends StatelessWidget {
  const ProductCategoryView({Key? key, required this.categoryMain})
      : super(key: key);

  final CategoryMain categoryMain;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      List<Widget> columnChildren = [];
      // 各層分類
      categoryMain.categoryLevel?.forEachIndexed((index, category) {
        if (category.categoryName?.isNotEmpty == true) {
          // 是否為末層
          bool isLastIndex =
              index == ((categoryMain.categoryLevel?.length ?? 1) - 1);

          // 限制文字長度
          Widget text = LimitedBox(
            maxWidth: constraints.minWidth - 30,
            child: Text(category.categoryName!,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.caption?.copyWith(
                    fontSize: 14.0,
                    color: Theme.of(context).primaryColor,
                    decoration: TextDecoration.underline)),
          );

          // 若不是最末層, 最後需加 > 符號
          if (isLastIndex) {
            columnChildren.add(text);
          } else {
            columnChildren.add(Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                text,
                const SizedBox(
                  width: 8,
                ),
                Text('>',
                    style: Theme.of(context).textTheme.caption?.copyWith(
                          color: UdiColors.brownGrey,
                          fontSize: 14.0,
                        ))
              ],
            ));
          }
        }
      });

      return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: columnChildren);
    });
  }
}
