import 'package:flutter/material.dart';

import '../../../device/utils/my_plus_colors.dart';

enum ProductDividerType { short, long }

class ProductDividerWidget extends StatelessWidget {
  const ProductDividerWidget({Key? key, this.type = ProductDividerType.short})
      : super(key: key);

  final ProductDividerType type;

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: 1,
      thickness: 1,
      color: UdiColors.veryLightGrey2,
      indent: type == ProductDividerType.short ? 12 : 0,
      endIndent: type == ProductDividerType.short ? 12 : 0,
    );
  }
}
