import 'package:brandstores/src/app/utils/screen_config.dart';
import 'package:flutter/material.dart';

import '../../../device/utils/my_plus_colors.dart';

class ProductDividerWidget extends StatelessWidget {
  const ProductDividerWidget({Key? key, this.dividerWidth}) : super(key: key);

  final double? dividerWidth;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: dividerWidth ?? SizeConfig.screenWidth - 24,
        height: 1,
        decoration: const BoxDecoration(color: UdiColors.defaultBorder));
  }
}
