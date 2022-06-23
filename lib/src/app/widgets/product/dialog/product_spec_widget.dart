import 'package:brandstores/src/app/utils/screen_config.dart';
import 'package:brandstores/src/app/widgets/product/dialog/product_dialog_preorder_date_widget.dart';
import 'package:flutter/material.dart';

import '../../../../domain/entities/product/product.dart';
import '../product_bottom_bar_widget.dart';
import 'product_dialog_spec_topbar.dart';

class ProductSpecWidget extends StatefulWidget {
  // 商品資料
  final Product product;
  // 選取的商品 id
  final int? productId;
  // 初始規格
  final AddToCartParams? initParams;
  // 選取的規格
  final ValueChanged<AddToCartParams>? specChoosed;

  /// The callback that is called when the favorite icon is tapped.
  final VoidCallback? favoriteTapped;

  /// The callback that is called when the addToCart button is tapped.
  final VoidCallback? addToCartTapped;

  const ProductSpecWidget(
      {Key? key,
      required this.product,
      this.productId,
      this.initParams,
      this.specChoosed,
      this.favoriteTapped,
      this.addToCartTapped})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _ProductSpecWidgetState();
}

class _ProductSpecWidgetState extends State<ProductSpecWidget> {
  // 目前選取的規格
  late AddToCartParams _selectedParams;

  @override
  void initState() {
    //
    if (widget.initParams != null) {
      _selectedParams = widget.initParams!;
    } else {
      _selectedParams = widget.product.getAddToCartParams(widget.productId);
    }

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: SizeConfig.screenWidth,
        decoration: const BoxDecoration(color: Colors.transparent),
        child: SingleChildScrollView(
            child: Column(
          children: [
            // 選規標題列
            ProductDialogSpecTopBarWidget(
              selectedParams: _selectedParams,
              specType: widget.product.specType,
              promotionRate: widget.product.discountRate,
            ),

            // 出貨日期
            //if (ShippedType.normal != widget.product.shippedType)
            ProductDialogPreorderRowWidget(
              product: widget.product,
              selectedParams: _selectedParams,
              dateSelected: (date) {
                setState(() {
                  _selectedParams.deliveryDate = date;
                });
                if (widget.specChoosed != null) {
                  widget.specChoosed!(_selectedParams);
                }
              },
            ),

            // 底部按鈕
            ProductBottomBarWidget(
              product: widget.product,
              type: ProductBottomTarType.spec,
              favoriteTapped: () {
                if (widget.favoriteTapped != null) {
                  widget.favoriteTapped!();
                }
              },
              addToCartTapped: () {
                if (widget.addToCartTapped != null) {
                  widget.addToCartTapped!();
                }
              },
            )
          ],
        )));
  }
}
