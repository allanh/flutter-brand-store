import 'package:brandstores/src/device/utils/my_plus_colors.dart';
import 'package:brandstores/src/domain/entities/product/shipped_method.dart';
import 'package:flutter/material.dart';

/// 付款列
class ProductShipped extends StatelessWidget {
  const ProductShipped({Key? key, required this.methods}) : super(key: key);

  final List<ShippedMethod> methods;

  @override
  Widget build(BuildContext context) {
    List<Widget> list = [];
    for (var method in methods) {
      List<Widget> children = [];
      // 宅配(本島)
      children.add(Text('${method.type?.name}(${method.mainOrOutlying})',
          style: Theme.of(context)
              .textTheme
              .caption
              ?.copyWith(fontSize: 14.0, color: UdiColors.greyishBrown)));
      children.add(const SizedBox(
        height: 8,
      ));
      // 運費計算方式
      if (methods.isNotEmpty) {
        children.add(DefaultTextStyle(
            style: Theme.of(context)
                    .textTheme
                    .caption
                    ?.copyWith(fontSize: 12.0, color: UdiColors.brownGrey) ??
                const TextStyle(),
            child: _getShippedCost(context)));
      }

      list.add(Column(children: children));
      list.add(const SizedBox(height: 8));
    }
    list.removeLast();
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: list);
  }

  /// 運費計算方式
  Widget _getShippedCost(BuildContext context) {
    ShippedMethod method = methods.first;
    switch (method.costType) {
      case CostType.free:
        return const Text('全站免運費');
      case CostType.fixed:
        return Text('每筆訂單收取固定運費${method.fixedCost}元');
      case CostType.range:
        return _getShippedCostRangeInfo(method);
      default:
        break;
    }
    return const SizedBox.shrink();
  }

  /// 取得運費級距費用
  Widget _getShippedCostRangeInfo(ShippedMethod method) {
    List<Widget> list = [Text('全站級距運費，基本運費為${method.fixedCost}元')];
    method.rangeInfo?.forEach((element) {
      list.add(Text('訂單金額滿${element.lowerLimit}元(含) 以上，運費${element.cost}元'));
    });
    return Column(children: list);
  }
}
