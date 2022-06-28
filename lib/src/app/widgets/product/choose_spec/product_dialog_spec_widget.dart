import 'package:brandstores/src/app/utils/screen_config.dart';
import 'package:brandstores/src/app/widgets/product/product_divider_widget.dart';
import 'package:brandstores/src/domain/entities/product/spec_sku.dart';
import 'package:flutter/material.dart';

import '../../../../domain/entities/product/product.dart';
import '../../../../domain/entities/product/shipped_method.dart';
import '../product_bottom_bar_widget.dart';
import 'product_dialog_spec_item_row_widget.dart';
import 'product_dialog_spec_topbar.dart';

// 選規頁
class ProductSpecWidget extends StatefulWidget {
  // 商品資料
  final Product product;
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
    }

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: SizeConfig.screenWidth,
        child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // 選規標題列
              ProductDialogSpecTopBarWidget(
                selectedParams: _selectedParams,
                specType: widget.product.specType,
                promotionRate: widget.product.discountRate,
              ),

              const Positioned(
                  bottom: 0,
                  child: ProductDividerWidget(type: ProductDividerType.long)),

              LimitedBox(
                  maxHeight: SizeConfig.screenHeight * 0.6,
                  child: Container(
                      decoration: const BoxDecoration(color: Colors.white),
                      child: SingleChildScrollView(
                          child: Column(children: [
                        // 出貨日期
                        if (ShippedType.normal != widget.product.shippedType)
                          ProductDialogSpecItemRowWidget(
                            type: SpecItemType.date,
                            title: '出貨日期',
                            product: widget.product,
                            selectedParams: _selectedParams,
                            dateSelected: (date) {
                              // 更新出貨日期
                              setState(() {
                                _selectedParams.deliveryDate = date;
                              });
                              if (widget.specChoosed != null) {
                                widget.specChoosed!(_selectedParams);
                              }
                            },
                          ),

                        if (ShippedType.normal != widget.product.shippedType)
                          const ProductDividerWidget(),

                        // 規格1
                        if (SpecType.none != widget.product.specType)
                          ProductDialogSpecItemRowWidget(
                            type: SpecItemType.spec1,
                            title: widget.product.specLv1Title!,
                            product: widget.product,
                            selectedParams: _selectedParams,
                            specSelected: (info) {
                              // 更新規格1和商品資訊
                              setState(() {
                                _selectedParams
                                  ..updateProductInfo(info)
                                  ..selectedProductInfo = info;
                              });
                              if (widget.specChoosed != null) {
                                widget.specChoosed!(_selectedParams);
                              }
                            },
                          ),

                        if (SpecType.none != widget.product.specType)
                          const ProductDividerWidget(),

                        // 規格2
                        if (SpecType.double == widget.product.specType)
                          ProductDialogSpecItemRowWidget(
                            type: SpecItemType.spec2,
                            title: widget.product.specLv2Title!,
                            product: widget.product,
                            selectedParams: _selectedParams,
                            specSelected: (info) {
                              // 更新規格2和商品資訊
                              setState(() {
                                _selectedParams
                                  ..updateProductInfo(info)
                                  ..selectedProductInfo = info;
                              });
                              if (widget.specChoosed != null) {
                                widget.specChoosed!(_selectedParams);
                              }
                            },
                          ),

                        if (SpecType.double == widget.product.specType)
                          const ProductDividerWidget(),
                      ])))),

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
              ),
            ]));
  }
}
