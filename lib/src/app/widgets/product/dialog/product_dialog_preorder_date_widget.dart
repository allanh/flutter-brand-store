import 'package:brandstores/src/app/utils/constants.dart';
import 'package:brandstores/src/app/utils/screen_config.dart';
import 'package:brandstores/src/domain/entities/product/shipped_method.dart';
import 'package:brandstores/src/domain/entities/product/spec_sku.dart';
import 'package:brandstores/src/extension/string_extension.dart';
import 'package:flutter/material.dart';

import '../../../../device/utils/my_plus_colors.dart';
import '../../../../domain/entities/product/product.dart';
import 'spec_item_widget.dart';

class ProductDialogPreorderRowWidget extends StatefulWidget {
  const ProductDialogPreorderRowWidget(
      {Key? key,
      required this.product,
      required this.selectedParams,
      this.dateSelected})
      : super(key: key);
  // 商品
  final Product product;
  // 選取的規格的參數
  final AddToCartParams selectedParams;
  // 點選事件
  final ValueChanged<String>? dateSelected;

  @override
  State<StatefulWidget> createState() => _ProductDialogPreorderRowWidgetState();
}

class _ProductDialogPreorderRowWidgetState
    extends State<ProductDialogPreorderRowWidget> {
  // 目前選取的項目
  int _currentIndex = 0;

  @override
  void initState() {
    if (widget.selectedParams.deliveryDate?.isNotEmpty == true) {
      // 已選的出貨日期
      int? index = widget.product.shippedPreorderDate
              ?.indexOf(widget.selectedParams.deliveryDate ?? '') ??
          0;
      // 找不到的話取第一個
      _currentIndex = index >= 0 ? index : 0;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Container(
        width: SizeConfig.screenWidth,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
        decoration: const BoxDecoration(color: Colors.white),
        child: DefaultTextStyle(
            style: Theme.of(context).textTheme.caption?.copyWith(
                    height: 1.714, // 24pt
                    fontSize: 14.0,
                    color: UdiColors.brownGrey) ??
                const TextStyle(),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text('出貨日期'),
              const SizedBox(
                height: 6,
              ),
              _buildDate(),
              if (widget.product.shippedType == ShippedType.custom ||
                  widget.product.shippedType == ShippedType.contact)
                const SizedBox(
                  height: 12,
                ),
            ])),
      );

  /// 出貨日期列
  Widget _buildDate() {
    switch (widget.product.shippedType) {
      case ShippedType.custom:
        return Text('此商品於付款完成後 ${widget.product.shippedCustomDay} 天開始陸續出貨');
      case ShippedType.contact:
        return const Text('因商品屬性，將有專人與您約定送貨日期');
      case ShippedType.preorder:
        return buildPreOrderDate();
      default:
        return const SizedBox.shrink();
    }
  }

  /// 預購日期列
  Widget buildPreOrderDate() => SizedBox(
        width: 351 * SizeConfig.screenRatio,
        child: Wrap(
          spacing: 10,
          runSpacing: 10,
          children: List.generate(
              widget.product.shippedPreorderDate?.length ?? 0, (index) {
            // 規格項目
            return SpecItemWidget(
              displayType: SpecDisplay.text,
              isSelected: index == _currentIndex,
              isEnabled: true,
              onItemSelected: () {
                // 點擊事件，僅允許單選
                if (index != _currentIndex) {
                  setState(() {
                    _currentIndex = index;
                  });
                  if (widget.dateSelected != null) {
                    widget.dateSelected!(
                        widget.product.shippedPreorderDate![index]);
                  }
                }
              },
              // 轉換日期格式
              text: widget.product.shippedPreorderDate?[index]
                  .convertDateFormat(serverDateFormat, shortDateFormat),
            );
          }),
        ),
      );
}
