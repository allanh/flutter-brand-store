import 'package:brandstores/src/device/utils/my_plus_colors.dart';
import 'package:flutter/material.dart';

import '../../../domain/entities/product/product.dart';
import '../../utils/screen_config.dart';
import '../udi_style/udi_button.dart';

enum ProductBottomTarType { normal, spec, freebie, addon, close }

/// 底部按鈕列
class ProductBottomBarWidget extends StatelessWidget {
  // 商品資料
  final Product product;

  /// 底部按鈕類型
  final ProductBottomTarType type;

  /// The callback that is called when the favorite icon is tapped.
  final VoidCallback? favoriteTapped;

  /// The callback that is called when the addToCart button is tapped.
  final VoidCallback? addToCartTapped;

  /// The callback that is called when the buyNow button is tapped.
  final VoidCallback? buyNowTapped;

  const ProductBottomBarWidget(
      {Key? key,
      required this.product,
      this.type = ProductBottomTarType.normal,
      this.favoriteTapped,
      this.addToCartTapped,
      this.buyNowTapped})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 判斷是否可購買
    bool _enabled = ProductStatus.buyable == product.status;
    final barHeight = 50 * SizeConfig.screenRatio;

    // 最多顯示兩筆
    return Container(
        width: SizeConfig.screenWidth,
        height: barHeight,
        decoration: const BoxDecoration(color: Colors.white),
        child: Flex(direction: Axis.horizontal, children: [
          // 收藏按鈕
          Expanded(
            flex: 52,
            child: SizedBox(
                height: barHeight,
                child: IconButton(
                    icon: const Icon(Icons.favorite_outline),
                    onPressed: () {
                      if (favoriteTapped != null) {
                        favoriteTapped!();
                      }
                    })),
          ),

          // 加入購物車按鈕
          if (_enabled && addToCartTapped != null)
            Expanded(
              flex: type == ProductBottomTarType.spec ? 324 : 162,
              child: SizedBox(
                  height: barHeight,
                  child: UdiButton(
                      text: '加入購物車',
                      padding: EdgeInsets.zero,
                      radius: 0,
                      opacity: 0.8,
                      onPressed: () => addToCartTapped!())),
            ),

          // 立即購買按鈕
          if (_enabled && buyNowTapped != null)
            Expanded(
              flex: 162,
              child: SizedBox(
                  height: barHeight,
                  child: UdiButton(
                      text: '立即購買',
                      padding: EdgeInsets.zero,
                      radius: 0,
                      onPressed: () => buyNowTapped!())),
            ),

          // 無法購買的狀態
          if (!_enabled)
            Expanded(
                flex: 324,
                child: Container(
                  alignment: Alignment.center,
                  height: barHeight,
                  decoration: const BoxDecoration(color: UdiColors.white2),
                  child: Text(
                    ProductBottomTarType.spec == type
                        ? '加入購物車'
                        : ProductStatus.comingSoon == product.status
                            ? '即將開賣，敬請期待'
                            : '搶購一空',
                    style: Theme.of(context)
                        .textTheme
                        .caption
                        ?.copyWith(fontSize: 18.0, color: UdiColors.brownGrey2),
                  ),
                )),
        ]));
  }
}
