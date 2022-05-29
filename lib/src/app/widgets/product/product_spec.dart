import 'package:brandstores/src/device/utils/my_plus_colors.dart';
import 'package:flutter/material.dart';

import '../../../domain/entities/product/product.dart';

/// 促銷活動列
class ProductSpecView extends StatelessWidget {
  const ProductSpecView({Key? key, required this.info}) : super(key: key);

  final ProductInfo info;

  @override
  Widget build(BuildContext context) {
    // 最多顯示兩筆
    return Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        constraints: const BoxConstraints(minHeight: 44),
        child: Row(
          children: [
            Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
              Container(
                alignment: Alignment.center,
                height: 20,
                child: Text('測試',
                    style: Theme.of(context).textTheme.caption?.copyWith(
                        fontSize: 14.0, color: UdiColors.greyishBrown)),
              ),
              const SizedBox(height: 5),
              Container(
                alignment: Alignment.center,
                height: 20,
                child: Text('test',
                    style: Theme.of(context).textTheme.caption?.copyWith(
                        fontSize: 14.0, color: UdiColors.greyishBrown)),
              ),
            ])
          ],
        ));
  }
}
