import 'package:brandstores/src/app/widgets/product/small_product.dart';
import 'package:brandstores/src/device/utils/my_plus_colors.dart';
import 'package:flutter/material.dart';

import '../../../domain/entities/product/product.dart';
import '../../utils/screen_config.dart';

/// 加價購列
class ProductFreeBieView extends StatelessWidget {
  const ProductFreeBieView({Key? key, required this.freeBies})
      : super(key: key);

  final List<Product> freeBies;

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
          // 贈品列表
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
      itemCount: freeBies.take(4).length,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          childAspectRatio: 60 / 81,
          crossAxisSpacing: 8 * ratio),
      itemBuilder: (context, index) {
        return SmallProduct(
            type: SmallProductType.freebie,
            product: freeBies[index],
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
