import 'package:brandstores/src/app/utils/screen_config.dart';
import 'package:brandstores/src/app/widgets/product/dialog/product_dialog_title_widget.dart';
import 'package:flutter/material.dart';

import '../../../../domain/entities/product/product.dart';
import '../../../pages/product/product_controller.dart';
import '../product_bottom_bar_widget.dart';

class BaseProductDialogWidget extends StatelessWidget {
  final String? title;
  final Widget child;
  // 底部按鈕類型
  final ProductBottomTarType buttomType;
  // 商品
  final Product product;
  // 商品 Controller
  final ProductController controller;

  const BaseProductDialogWidget({
    Key? key,
    required this.child,
    required this.product,
    required this.controller,
    this.buttomType = ProductBottomTarType.normal,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
          body: Container(
        padding: EdgeInsets.only(top: SizeConfig.statusBarHeight),
        width: SizeConfig.screenWidth,
        height: SizeConfig.screenHeight,
        decoration: BoxDecoration(color: Colors.black.withOpacity(0.7)),
        child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
          // 標題列
          if (title?.isNotEmpty == true)
            ProductDialogTitleWidget(title: title!),

          // child layout
          SizedBox(
            width: SizeConfig.screenWidth,
            child: child,
          ),

          // 底部按鈕
          ProductBottomBarWidget(
            product: product,
            type: buttomType,
            favoriteTapped: () => controller.handlefavoriteTapped(),
            addToCartTapped: () => controller.handleAddToCartTapped(),
          )
        ]),
      ));
}
