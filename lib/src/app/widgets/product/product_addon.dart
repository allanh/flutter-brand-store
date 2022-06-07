import 'package:brandstores/src/app/widgets/product/small_product.dart';
import 'package:brandstores/src/device/utils/my_plus_colors.dart';
import 'package:brandstores/src/extension/iterable_extension.dart';
import 'package:brandstores/src/extension/num_extension.dart';
import 'package:flutter/material.dart';

import '../../../domain/entities/product/product.dart';
import '../../utils/screen_config.dart';

/// 加價購列
class ProductAddonView extends StatelessWidget {
  const ProductAddonView(
      {Key? key,
      required this.addons,
      required this.selectedAddons,
      this.isSelected})
      : super(key: key);

  final List<Product> addons;
  final List<AddToCartParams> selectedAddons;
  // 點擊事件，若不需要點擊可傳 null
  final ValueChanged<bool>? isSelected;

  @override
  Widget build(BuildContext context) {
    TextStyle? _strawberryStyle = Theme.of(context)
        .textTheme
        .caption
        ?.copyWith(fontSize: 14.0, color: UdiColors.strawberry);

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final ratio = SizeConfig.screenRatio;
        return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          // 提示文字
          DefaultTextStyle(
              style: Theme.of(context).textTheme.caption?.copyWith(
                      fontSize: 14.0, color: UdiColors.greyishBrown) ??
                  const TextStyle(),
              child: SizedBox(
                  height: 24 * ratio,
                  child: selectedAddons.isNotEmpty
                      ? Text.rich(TextSpan(children: [
                          const TextSpan(text: "已選購 "),
                          TextSpan(
                              text: selectedAddons.length.toString(),
                              style: _strawberryStyle),
                          const TextSpan(text: " 件，共 "),
                          TextSpan(
                              text: selectedAddons
                                  .sumBy((e) => e.addonFixedPrice ?? 0)
                                  .toDollarString(),
                              style: _strawberryStyle),
                        ]))
                      : const Text('一起買，更優惠'))),

          SizedBox(height: 8 * ratio),
          // 加購品列表

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
      padding: const EdgeInsets.all(0),
      itemCount: addons.take(4).length,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          childAspectRatio: 60 / 81,
          crossAxisSpacing: 8 * ratio),
      itemBuilder: (context, index) {
        return SmallProduct(
            type: SmallProductType.addon,
            product: addons[index],
            onItemTap: (product) => debugPrint('tap addon: ${product.no}')
            //isSelected: (bool value) {
            // setState(() {
            //   if (value) {
            //     selectedList.add(itemList[index]);
            //   } else {
            //     selectedList.remove(itemList[index]);
            //   }
            );
      },
    );
  }
}
