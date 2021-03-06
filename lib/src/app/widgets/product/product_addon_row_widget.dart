import 'package:brandstores/src/app/widgets/product/small_product_item_widget.dart';
import 'package:brandstores/src/device/utils/my_plus_colors.dart';
import 'package:brandstores/src/extension/iterable_extension.dart';
import 'package:brandstores/src/extension/num_extension.dart';
import 'package:flutter/material.dart';

import '../../../domain/entities/product/product.dart';
import '../../utils/screen_config.dart';

/// 加價購列
class ProductAddonRowWidget extends StatelessWidget {
  const ProductAddonRowWidget(
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

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      // 提示文字
      DefaultTextStyle(
          style: Theme.of(context)
                  .textTheme
                  .caption
                  ?.copyWith(fontSize: 14.0, color: UdiColors.greyishBrown) ??
              const TextStyle(),
          child: SizedBox(
              height: 24 * SizeConfig.screenRatio,
              child: selectedAddons.isNotEmpty
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
                  : const Text('一起買，更優惠'))),

      SizedBox(height: 8 * SizeConfig.screenRatio),
      // 加購品列表
      SizedBox(
        height: 81 * SizeConfig.screenRatio,
        child: _buildGrid(SizeConfig.screenRatio),
      )
    ]);
  }

  GridView _buildGrid(double ratio) {
    return GridView.builder(
      padding: const EdgeInsets.all(0),
      itemCount: addons.take(4).length,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          childAspectRatio: 60 / 90,
          crossAxisSpacing: 8 * ratio),
      itemBuilder: (context, index) {
        return SmallProductItemWidget(
            type: SmallProductItemType.addon,
            product: addons[index],
            onTapItem: (product) => debugPrint('tap addon: ${product.no}')
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
