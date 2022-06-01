import 'package:brandstores/src/app/widgets/product/small_product.dart';
import 'package:brandstores/src/device/utils/my_plus_colors.dart';
import 'package:brandstores/src/extension/iterable_extension.dart';
import 'package:brandstores/src/extension/num_extension.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';

import '../../../domain/entities/product/product.dart';

/// 加價購列
class ProductAddonView extends StatelessWidget {
  const ProductAddonView(
      {Key? key, required this.addons, required this.selectedAddons})
      : super(key: key);

  final List<Product> addons;
  final List<AddToCartParams> selectedAddons;

  @override
  Widget build(BuildContext context) {
    // 最多顯示兩筆
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final ratio = constraints.maxWidth / 265;
        debugPrint('parent width: ${constraints.maxWidth}');
        return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(
            height: 20,
            child: FittedBox(
                fit: BoxFit.fitWidth,
                child: Text(
                    selectedAddons.isNotEmpty
                        ? '已選購 ${selectedAddons.length} 件，共 ${selectedAddons.sumBy((e) => e.addonFixedPrice ?? 0).toDollarString()}'
                        : '一起買，更優惠',
                    style: Theme.of(context).textTheme.caption?.copyWith(
                        fontSize: 14.0, color: UdiColors.greyishBrown))),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 81 * ratio,
            child: _buildGrid(ratio),
          )
        ]);
      },
    );
  }

  GridView _buildGrid(double ratio) {
    return GridView.builder(
      itemCount: addons.take(4).length,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          childAspectRatio: 60 / 81,
          crossAxisSpacing: 8 * ratio),
      itemBuilder: (context, index) {
        return SmallProduct(
          product: addons[index],
          ratio: ratio,
          // isSelected: (bool value) {
          //   setState(() {
          //     if (value) {
          //       selectedList.add(itemList[index]);
          //     } else {
          //       selectedList.remove(itemList[index]);
          //     }
          //   });
          //   print("$index : $value");
        );
      },
    );
  }
}
