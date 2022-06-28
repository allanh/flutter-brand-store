import 'package:brandstores/src/app/utils/screen_config.dart';
import 'package:brandstores/src/domain/entities/product/shipped_method.dart';
import 'package:brandstores/src/domain/entities/product/spec_sku.dart';
import 'package:flutter/material.dart';

import '../../../../device/utils/my_plus_colors.dart';
import '../../../../domain/entities/product/product.dart';
import 'product_dialog_spec_item_widget.dart';

// 選規項目列
class ProductDialogSpecItemRowWidget extends StatefulWidget {
  const ProductDialogSpecItemRowWidget(
      {Key? key,
      required this.title,
      required this.type,
      required this.product,
      required this.selectedParams,
      this.dateSelected,
      this.specSelected})
      : super(key: key);
  // 標題
  final String title;
  // 項目類型
  final SpecItemType type;
  // 商品
  final Product product;
  // 選取的規格的參數
  final AddToCartParams selectedParams;
  // 選取日期的結果
  final ValueChanged<String>? dateSelected;
  // 選取規格的結果
  final ValueChanged<ProductInfo?>? specSelected;

  @override
  State<StatefulWidget> createState() => _ProductDialogSpecItemRowWidgetState();
}

class _ProductDialogSpecItemRowWidgetState
    extends State<ProductDialogSpecItemRowWidget> {
  // 目前選取的項目索引值, 若無選取時為 -1
  int _currentIndex = -1;
  SpecDisplay _displayType = SpecDisplay.text;

  @override
  void initState() {
    switch (widget.type) {
      case SpecItemType.date:
        // 已選的出貨日期
        if (ShippedType.preorder == widget.product.shippedType) {
          _currentIndex = widget.product.getSelectedSpecIndex(
              preorderDate: widget.selectedParams.deliveryDate);
        }
        break;

      // 已選的規格1
      case SpecItemType.spec1:
        _displayType = widget.product.specLv1Display ?? SpecDisplay.text;
        _currentIndex = widget.product
            .getSelectedSpecIndex(spec1Id: widget.selectedParams.specLv1Id);

        break;

      // 已選的規格2
      case SpecItemType.spec2:
        _displayType = widget.product.specLv2Display ?? SpecDisplay.text;
        _currentIndex = widget.product
            .getSelectedSpecIndex(spec2Id: widget.selectedParams.specLv2Id);
        break;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) => Container(
        width: SizeConfig.screenWidth,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
        decoration: const BoxDecoration(color: Colors.white),
        child: DefaultTextStyle(
            style: Theme.of(context).textTheme.caption?.copyWith(
                    height: 1.714, // 24pt
                    fontSize: 14.0,
                    color: UdiColors.brownGrey) ??
                const TextStyle(),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(widget.title),
              const SizedBox(
                height: 6,
              ),
              // 建立選項列
              _buildSpecRow(widget.type),
              const SizedBox(
                height: 12,
              ),
            ])),
      );

  /// 建立選項列
  Widget _buildSpecRow(SpecItemType type) {
    switch (type) {
      // 規格1
      case SpecItemType.spec1:
        return _buildSpecItem(type, widget.product.specInfo1?.length ?? 0);

      // 規格2
      case SpecItemType.spec2:
        return _buildSpecItem(type, widget.product.specInfo2?.length ?? 0);

      // 訂製/客約/預購日期
      case SpecItemType.date:
        switch (widget.product.shippedType) {
          case ShippedType.custom:
            return Text('此商品於付款完成後 ${widget.product.shippedCustomDay} 天開始陸續出貨');
          case ShippedType.contact:
            return const Text('因商品屬性，將有專人與您約定送貨日期');
          case ShippedType.preorder:
            return _buildSpecItem(
                type, widget.product.shippedPreorderDate?.length ?? 0);
          default:
            return const SizedBox.shrink();
        }
    }
  }

  /// 選規項目列
  Widget _buildSpecItem(SpecItemType type, int length) {
    return SizedBox(
      width: 351 * SizeConfig.screenRatio,
      child: Wrap(
        spacing: 10,
        runSpacing: 10,
        children: List.generate(length, (index) {
          // 規格是否能選
          final _isEnabled = _isItemEnable(type, index);

          // 規格項目
          return ProductDialogSpecItemWidget(
            displayType: _displayType,
            isSelected: _isEnabled && index == _currentIndex,
            isEnabled: _isEnabled,
            // 點擊事件，僅允許單選
            onItemSelected: () {
              if (_isEnabled && index != _currentIndex) {
                _handleItemSelected(index);
              }
            },
            // 規格項目文字
            text: widget.product.getSpecText(widget.type, index),
          );
        }),
      ),
    );
  }

  /// 判斷規格項目是否能選
  bool _isItemEnable(SpecItemType type, int index) {
    bool _isEnabled = true;
    switch (type) {
      case SpecItemType.spec1:
        _isEnabled = widget.product.isSpecItemEnabled(
            specLv1Id: widget.product.specInfo1?[index].specLv1Id,
            specLv2Id: widget.selectedParams.specLv2Id);
        break;
      case SpecItemType.spec2:
        _isEnabled = widget.product.isSpecItemEnabled(
          specLv1Id: widget.selectedParams.specLv1Id,
          specLv2Id: widget.product.specInfo2?[index].specLv2Id,
        );
        break;
      default:
        break;
    }
    return _isEnabled;
  }

  /// 點擊事件，依規格類型回傳結果至 [widget.specSelected] 或 [widget.dateSelected]
  void _handleItemSelected(int index) {
    setState(() {
      _currentIndex = index;
    });

    switch (widget.type) {
      // 規格1
      case SpecItemType.spec1:
        if (widget.specSelected != null) {
          final info = widget.product.getProudctInfo(
              specLv1Id: widget.product.specInfo1![index].specLv1Id!,
              specLv2Id: widget.selectedParams.specLv2Id);
          widget.specSelected!(info);
        }
        break;

      // 規格2
      case SpecItemType.spec2:
        if (widget.specSelected != null) {
          final info = widget.product.getProudctInfo(
              specLv1Id: widget.selectedParams.specLv1Id,
              specLv2Id: widget.product.specInfo2![index].specLv2Id!);
          widget.specSelected!(info);
        }
        break;

      // 訂製/客約/預購日期
      case SpecItemType.date:
        if (widget.dateSelected != null &&
            ShippedType.preorder == widget.product.shippedType) {
          widget.dateSelected!(widget.product.shippedPreorderDate![index]);
        }
    }
  }
}
